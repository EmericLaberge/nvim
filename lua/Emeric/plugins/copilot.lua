return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Use copilot.lua as the backend and enable its cmp integration (copilot-cmp
    -- registers a cmp source named 'copilot'). We disable inline suggestions
    -- so cmp is the primary UX surface.
    local ok, copilot = pcall(require, "copilot")
    if ok and copilot then
      copilot.setup({
        panel = { enabled = false },
        suggestion = { enabled = false },
        cmp = { enabled = true, method = "getCompletionsCycling" },
      })
    end

    vim.keymap.set('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { noremap = true, silent = true, desc = "Enable Copilot" })
    vim.keymap.set('n', '<Leader>cd', '<cmd>Copilot disable<CR>', { noremap = true, silent = true, desc = "Disable Copilot" })

    vim.keymap.set('n', '<Leader>ct', function()
      local success, copilot_suggestion = pcall(require, "copilot.suggestion")
      if success and copilot_suggestion and copilot_suggestion.toggle_auto_trigger then
        copilot_suggestion.toggle_auto_trigger()
      else
        vim.notify("Copilot plugin not loaded yet.", vim.log.levels.WARN)
      end
    end, { noremap = true, silent = true, desc = "Toggle Copilot AutoTrigger" })
  end,
}
