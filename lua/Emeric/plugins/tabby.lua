-- Set your leader key
vim.g.mapleader = " " -- Assuming space is your leader key
vim.g.tabby_agent_start_command = { "npx", "tabby-agent", "--stdio" }
vim.g.tabby_inline_completion_trigger = "manual"
vim.g.tabby_inline_completion_keybinding_accept = "<A-Space>"
-- Enable Tabby completion (set to auto mode)
vim.api.nvim_set_keymap('n', '<leader>te', ":let g:tabby_inline_completion_trigger='auto'<CR>",
  { noremap = true, silent = true, desc = " Enable Tabby " })

-- Disable Tabby completion (set to manual mode)
vim.api.nvim_set_keymap('n', '<leader>td', ":let g:tabby_inline_completion_trigger='manual'<CR>",
  { noremap = true, silent = true, desc = " Disable Tabby " })

-- vim.api.nvim_set_keymap('n','<leader>ce', ":let g:tabby_trigger_mode='auto'<CR>", { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>cd', ":let g:tabby_trigger_mode='manual'<CR>", { noremap = true })
