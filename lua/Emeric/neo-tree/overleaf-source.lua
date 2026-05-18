local M = {
  name = "overleaf",
  display_name = "  Overleaf ",
}

local utils = require("neo-tree.utils")
local renderer = require("neo-tree.ui.renderer")
local file_items = require("neo-tree.sources.common.file-items")
local log = require("neo-tree.log")

local wrap = function(func)
  return utils.wrap(func, M.name)
end

local get_state = function()
  return require("neo-tree.sources.manager").get_state(M.name)
end

local state_data = {
  items = {},
  connected = false,
}

-- Convert Overleaf tree node to neo-tree item
local function overleaf_to_item(node, parent_path, context)
  local path = parent_path .. "/" .. node.name
  local _type = node.file and "file" or (node.directory and "directory" or "file")

  local item = file_items.create_item(context, path, _type)
  item.name = node.name
  item._overleaf_id = node.id
  item._overleaf_type = node.file and "file" or "directory"

  -- For directories, add children
  if node.directory then
    item.children = {}
    item.loaded = true

    -- Add files
    if node.fileList then
      for _, child in ipairs(node.fileList) do
        table.insert(item.children, overleaf_to_item(child, path, context))
      end
    end

    -- Add subdirectories
    if node.folderList then
      for _, child in ipairs(node.folderList) do
        table.insert(item.children, overleaf_to_item(child, path, context))
      end
    end
  else
    -- For files, determine extension for icons
    item.base = node.name:match("^([-_,()%s%w%i]+)%.")
    item.ext = node.name:match("%.([-_,()%s%w%i]+)$")
    item.exts = node.name:match("^[-_,()%s%w%i]+%.(.*)")
    item.name_lcase = node.name:lower()
  end

  return item
end

-- Fetch and parse Overleaf project tree
local function refresh_overleaf_tree(state)
  local ok, project = pcall(require, "overleaf.project")
  if not ok or not project._project_tree then
    state_data.connected = false
    return false
  end

  state_data.connected = true
  state_data.items = {}

  local tree = project._project_tree
  if tree.rootFolder then
    local context = file_items.create_context()
    context.state = state

    -- Add files from root
    if tree.rootFolder.fileList then
      for _, node in ipairs(tree.rootFolder.fileList) do
        table.insert(state_data.items, overleaf_to_item(node, state.path, context))
      end
    end

    -- Add directories from root
    if tree.rootFolder.folderList then
      for _, node in ipairs(tree.rootFolder.folderList) do
        table.insert(state_data.items, overleaf_to_item(node, state.path, context))
      end
    end
  end

  return true
end

-- Navigate function
M.navigate = function(state, path, path_to_reveal, callback, async)
  state.dirty = false

  if path == nil then
    path = "/overleaf"
  end

  if path ~= state.path then
    state.path = path
  end

  if path_to_reveal then
    renderer.position.set(state, path_to_reveal)
  end

  if not state_data.connected then
    local success = refresh_overleaf_tree(state)
    if not success then
      -- Show not connected message
      state.tree = require("nui.tree").Node({ id = "root", name = "Not connected", type = "message" })
      renderer.show(state)
      if type(callback) == "function" then
        vim.schedule(callback)
      end
      return
    end
  end

  -- Sort items
  table.sort(state_data.items, function(a, b)
    if a.type == b.type then
      return a.name:lower() < b.name:lower()
    else
      return a.type < b.type
    end
  end)

  renderer.show_nodes(state_data.items, state)

  if type(callback) == "function" then
    vim.schedule(callback)
  end
end

-- Refresh function
M.refresh = function(state)
  refresh_overleaf_tree(state)
  M.navigate(state, state.path)
end

-- Setup function
M.setup = function(config, global_config)
  local manager = require("neo-tree.sources.manager")

  -- Register custom commands during setup
  register_commands()

  -- Subscribe to Overleaf events
  manager.subscribe(M.name, {
    event = require("neo-tree.events").VIM_BUFFER_ENTER,
    handler = wrap(M.refresh),
  })
end

-- Register the source with neo-tree
function M.register()
  -- Commands are registered in setup, this is a no-op for now
end

-- Register custom commands
local function register_commands()
  local manager = require("neo-tree.sources.manager")

  -- Open file
  manager.register_custom_command("overleaf_open", function(state)
    local node = state.tree:get_node()
    if not node or node.type ~= "file" then
      return
    end

    local overleaf = pcall(require, "overleaf")
    if not overleaf then
      vim.notify("Overleaf plugin not loaded", vim.log.levels.ERROR)
      return
    end

    local doc_id = node._overleaf_id
    local doc_path = node.path
    require("overleaf").open_document(doc_id, doc_path)
  end)

  -- New file
  manager.register_custom_command("overleaf_new", function(state)
    local input = vim.fn.input("New file name: ")
    if input and input ~= "" then
      vim.cmd("Overleaf new " .. input)
      vim.defer_fn(function()
        M.refresh(get_state())
      end, 500)
    end
  end)

  -- New directory
  manager.register_custom_command("overleaf_new_dir", function(state)
    local input = vim.fn.input("New directory name: ")
    if input and input ~= "" then
      vim.cmd("Overleaf mkdir " .. input)
      vim.defer_fn(function()
        M.refresh(get_state())
      end, 500)
    end
  end)

  -- Delete
  manager.register_custom_command("overleaf_delete", function(state)
    local node = state.tree:get_node()
    if not node then
      return
    end

    local choice = vim.fn.confirm("Delete " .. node.name .. "?", "&Yes\n&No")
    if choice == 1 then
      vim.cmd("Overleaf delete")
      vim.defer_fn(function()
        M.refresh(get_state())
      end, 500)
    end
  end)

  -- Rename
  manager.register_custom_command("overleaf_rename", function(state)
    local node = state.tree:get_node()
    if not node then
      return
    end

    local new_name = vim.fn.input("Rename to: ", node.name)
    if new_name and new_name ~= "" and new_name ~= node.name then
      vim.cmd("Overleaf rename " .. new_name)
      vim.defer_fn(function()
        M.refresh(get_state())
      end, 500)
    end
  end)

  -- Upload
  manager.register_custom_command("overleaf_upload", function(state)
    local path = vim.fn.input("Upload local file: ", "", "file")
    if path and path ~= "" then
      vim.cmd("Overleaf upload " .. path)
      vim.defer_fn(function()
        M.refresh(get_state())
      end, 500)
    end
  end)
end

return M
