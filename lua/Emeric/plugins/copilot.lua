return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- lazy-load-friendly: only load on Copilot command so mappings that call
  -- Copilot work even before the plugin is fetched/loaded by lazy.
  init = function()
    -- Key mappings (use Vim commands to be safe with lazy-loading)
    vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>Copilot enable<CR>',
      { noremap = true, silent = true, desc = "Enable Copilot" })
    vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>Copilot disable<CR>',
      { noremap = true, silent = true, desc = "Disable Copilot" })
    vim.api.nvim_set_keymap('n', '<Leader>cf', '<cmd>Copilot! attach<CR>',
      { noremap = true, silent = true, desc = "Force Copilot Attach" })

    -- Toggle auto-trigger helper (works once Copilot is loaded)
    local function toggle_copilot_auto_trigger()
      local success, copilot_suggestion = pcall(require, "copilot.suggestion")
      if success then
        copilot_suggestion.toggle_auto_trigger()
      else
        vim.notify("Copilot plugin not loaded yet.", vim.log.levels.WARN)
      end
    end
    vim.api.nvim_set_keymap('n', '<Leader>co', '<cmd>lua toggle_copilot_auto_trigger()<CR>',
      { noremap = true, silent = true, desc = "Toggle Copilot AutoTrigger" })
  end,
  config = function()
    -- Auto-detect Node.js path based on OS
    local node_command = nil
    local home = vim.fn.expand("$HOME")

    -- Try to find node using which command first (more reliable for nvm)
    local which_result = vim.fn.system("which node 2>/dev/null"):gsub("%s+", "")
    if which_result ~= "" and vim.fn.executable(which_result) == 1 then
      node_command = which_result
    else
      -- Fallback: try common paths based on OS
      local paths = {}

      if vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1 then
        -- macOS paths
        paths = {
          home .. "/.nvm/versions/node/v22.17.0/bin/node",
          "/usr/local/bin/node",
          "/opt/homebrew/bin/node",
        }
      else
        -- Linux paths
        paths = {
          home .. "/.nvm/versions/node/v24.9.0/bin/node",
          home .. "/.nvm/versions/node/v22.17.0/bin/node",
          "/usr/bin/node",
        }
      end

      for _, path in ipairs(paths) do
        if vim.fn.executable(path) == 1 then
          node_command = path
          break
        end
      end
    end

    require("copilot").setup({
      copilot_node_command = node_command or "node", -- Use detected path or fallback to 'node' in PATH
      suggestion = { enabled = false, auto_trigger = false },
      panel = { enabled = false },
      filetypes = { markdown = true },
    })
  end,
}
