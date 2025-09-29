return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- lazy-load-friendly: only load on Copilot command so mappings that call
  -- Copilot work even before the plugin is fetched/loaded by lazy.
  init = function()
    -- Key mappings (use Vim commands to be safe with lazy-loading)
    vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { noremap = true, silent = true, desc = "Enable Copilot" })
    vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>Copilot disable<CR>', { noremap = true, silent = true, desc = "Disable Copilot" })

    -- Toggle auto-trigger helper (works once Copilot is loaded)
    local function toggle_copilot_auto_trigger()
      local success, copilot_suggestion = pcall(require, "copilot.suggestion")
      if success then
        copilot_suggestion.toggle_auto_trigger()
      else
        vim.notify("Copilot plugin not loaded yet.", vim.log.levels.WARN)
      end
    end
    vim.api.nvim_set_keymap('n', '<Leader>ct', '<cmd>lua toggle_copilot_auto_trigger()<CR>', { noremap = true, silent = true, desc = "Toggle Copilot AutoTrigger" })
  end,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false, auto_trigger = false },
      panel = { enabled = false },
      filetypes = { markdown = true },
    })
  end,
}
