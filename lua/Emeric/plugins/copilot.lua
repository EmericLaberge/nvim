-- Function to toggle Copilot's auto-trigger for the current buffer
local function toggle_copilot()
  require("copilot.suggestion").toggle_auto_trigger()


end
-- Key mappings
vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>lua require("copilot.command").enable()<CR>', { noremap = true, silent = true, desc = "Enable Copilot" })
vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>lua require("copilot.command").disable()<CR>', { noremap = true, silent = true, desc = "Disable Copilot" })
vim.api.nvim_set_keymap('n', '<Leader>ct', '<cmd>lua toggle_copilot()<CR>', { noremap = true, silent = true, desc = "Toggle Copilot" }) 
