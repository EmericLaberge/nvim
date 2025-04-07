-- Key mappings (Revised to use Vim commands for lazy-loading compatibility)
vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { noremap = true, silent = true, desc = "Enable Copilot" })
vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>Copilot disable<CR>', { noremap = true, silent = true, desc = "Disable Copilot" })

-- Your toggle function (keep as is, but be aware it only works AFTER Copilot is loaded/enabled)
local function toggle_copilot_auto_trigger()
  -- This require will only work if Copilot has already been loaded
  -- (e.g., after running :Copilot enable or :Copilot status)
  local success, copilot_suggestion = pcall(require, "copilot.suggestion")
  if success then
    copilot_suggestion.toggle_auto_trigger()
  else
    vim.notify("Copilot plugin not loaded yet.", vim.log.levels.WARN)
  end
end
vim.api.nvim_set_keymap('n', '<Leader>ct', '<cmd>lua toggle_copilot_auto_trigger()<CR>', { noremap = true, silent = true, desc = "Toggle Copilot AutoTrigger" })

-- Alternative: If you want a toggle that enables/disables the whole plugin
-- vim.api.nvim_set_keymap('n', '<Leader>ct', '<cmd>Copilot toggle<CR>', { noremap = true, silent = true, desc = "Toggle Copilot Enable/Disable" })
