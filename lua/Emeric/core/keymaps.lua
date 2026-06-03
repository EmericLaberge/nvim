-- Leader is set in init.lua to ensure it's defined before plugins load
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert Mode" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Search Highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete Character (No Register)" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" })   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Splits Equal" })  -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close Split" })    -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New Tab" })       -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close Tab" })   -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next Tab" })        --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous Tab" })    --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------
-- setup mapping to call :LazyGit
keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })



-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down (Visual)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up (Visual)" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Half Page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Half Page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })


-- remap cmd s  to save without having to press :w in insert mode
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>a", { desc = "Save File (Insert Mode)" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Yanking (Visual)" })

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Line to System Clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete (No Register)" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit Insert Mode (Ctrl+C)" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })

-- Formatting with conform.nvim
vim.keymap.set({ "n", "v" }, "<leader>f", function()
require("conform").format({
  lsp_format = "fallback",
  async = false,
  timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })

vim.keymap.set("n", "<leader>ft", function()
  local tools = {
    python = {
      { name = "ruff check", cmd = { "ruff", "check", "." } },
      { name = "mypy",       cmd = { "python3", "-m", "mypy" } },
      { name = "pylint",     cmd = { "pylint" } },
      { name = "black",      cmd = { "black", "-" } },
    },
    lua = {
      { name = "lua-language-server", cmd = { "lua-language-server" } },
    },
  }

  local ft = vim.bo.filetype
  local choices = tools[ft] or {}

  if #choices == 0 then
    vim.notify("No tools for " .. ft, vim.log.levels.WARN)
    return
  end

  vim.ui.select(choices, { prompt = "Tool:", format_item = function(t) return t.name end }, function(choice)
    if choice then
      local cmd = vim.deepcopy(choice.cmd)
      local name = choice.name
      if name == "black" then
        cmd[#cmd + 1] = vim.fn.expand("%")
      elseif name == "mypy" or name == "pylint" then
        cmd[#cmd + 1] = vim.fn.expand("%")
      elseif name == "ruff check" then
        cmd[#cmd + 1] = vim.fn.expand("%")
      end
      local output = vim.fn.systemlist(cmd)
      if vim.v.shell_error ~= 0 and #output > 0 then
        vim.fn.setqflist({}, " ", { title = name, items = {} })
        local qf_list = vim.fn.getqflist({ items = 0 }).items
        for _, line in ipairs(output) do
          local file, lnum, col, text = string.match(line, "^(.-):(%d+):?(%d*):?%s*(.*)")
          if file and lnum then
            table.insert(qf_list, {
              filename = file,
              lnum = tonumber(lnum),
              col = col and col ~= "" and tonumber(col) or 0,
              text = text or line,
            })
          else
            table.insert(qf_list, { text = line })
          end
        end
        vim.fn.setqflist({}, " ", { items = qf_list })
        vim.cmd("Trouble qflist open")
      else
        vim.notify(name .. ": OK", vim.log.levels.INFO)
      end
    end
  end)
end, { desc = "Run tool" })

vim.keymap.set("n", "<leader>fp", function()
  local ft = vim.bo.filetype
  local conform = require("conform")
local default_formatters = conform.list_formatters(0)
  local extras = {
    python = { "yapf", "ruff_format" },
  }
  local seen = {}
  local choices = {}
  local function add(c)
    if not seen[c] then
      seen[c] = true
      table.insert(choices, c)
    end
  end
  for _, f in ipairs(default_formatters) do
    add(type(f) == "string" and f or f.name)
  end
  for _, f in ipairs(extras[ft] or {}) do
    add(f)
  end
  if #choices == 0 then
    vim.notify("No formatters for this filetype", vim.log.levels.WARN)
    return
  end
  vim.ui.select(choices, { prompt = "Formatter:" }, function(choice)
    if choice then
      require("conform").format({ formatters = { choice }, async = false, timeout_ms = 1000 })
    end
  end)
end, { desc = "Pick formatter" })

-- Window navigation using Ctrl+h/j/k/l (useful and common mapping)
local function tmux_nav(dir_cmd, tmux_fn)
  -- dir_cmd: vim wincmd to try first (e.g. "wincmd h")
  -- tmux_fn: name of tmux.nvim helper (move_left/move_down/move_up/move_right)
  return function()
    local cur = vim.api.nvim_get_current_win()
    -- Try normal vim window movement first
    pcall(vim.cmd, dir_cmd)
    if vim.api.nvim_get_current_win() ~= cur then
      -- moved inside vim; done
      return
    end

    -- Couldn't move inside vim; if inside TMUX, try to move tmux pane
    if not vim.env.TMUX then
      return
    end

    local ok, tmux = pcall(require, "tmux")
    if ok and tmux and type(tmux[tmux_fn]) == "function" then
      pcall(tmux[tmux_fn])
      return
    end

    -- Fallback to tmux CLI if tmux.nvim isn't available
    local dir_flag_map = {
      move_left = "-L",
      move_down = "-D",
      move_up = "-U",
      move_right = "-R",
    }
    local flag = dir_flag_map[tmux_fn]
    if flag then
      pcall(vim.fn.system, { "tmux", "select-pane", flag })
    end
  end
end

vim.keymap.set("n", "<C-h>", tmux_nav("wincmd h", "move_left"), { desc = "Window Left -> Tmux Pane Left if none" })
vim.keymap.set("n", "<C-j>", tmux_nav("wincmd j", "move_down"), { desc = "Window Down -> Tmux Pane Down if none" })
vim.keymap.set("n", "<C-k>", tmux_nav("wincmd k", "move_up"), { desc = "Window Up -> Tmux Pane Up if none" })
vim.keymap.set("n", "<C-l>", tmux_nav("wincmd l", "move_right"), { desc = "Window Right -> Tmux Pane Right if none" })

-- Remap quickfix navigation to avoid colliding with Ctrl-window mappings
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix Item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List Item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous Location List Item" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace Word Under Cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make File Executable" })

-- Open current file with system default application (for PDFs, images, etc.)
vim.keymap.set("n", "<leader>o", function()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("No file to open", vim.log.levels.WARN)
    return
  end
  -- Use xdg-open on Linux, open on macOS, start on Windows
  -- Check macOS first since it's Unix-based (has("unix") returns 1 on macOS too)
  local open_cmd
  if vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    open_cmd = "xdg-open"
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    open_cmd = "start"
  else
    vim.notify("Unsupported system for opening files", vim.log.levels.ERROR)
    return
  end
  vim.fn.jobstart({ open_cmd, file_path }, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("Failed to open file with default application", vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "Open File with Default Application" })

-- Key mapping to toggle tiny-inline-diagnostic
vim.keymap.set("n", "<leader>l", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle Inline Diagnostics" })

vim.keymap.set('n', 'fw', ":HopWord<CR>", { desc = "Hop Word" })



local conceallevel = 0
vim.keymap.set("n", "<leader>cl", function()
  print("Conceal level changed ")
  vim.api.nvim_win_set_option(0, 'conceallevel', conceallevel)
  if conceallevel == 2 then
    conceallevel = 0
  else
    conceallevel = 2
  end
end, { noremap = true, desc = "Toggle Conceal Level" })


