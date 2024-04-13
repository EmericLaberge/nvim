-- Set your leader key
vim.g.mapleader = " "  -- Assuming space is your leader key



vim.g.tabby_trigger_mode = 'manual';
-- Enable Tabby completion (set to auto mode)
vim.api.nvim_set_keymap('n', '<leader>te', ":let g:tabby_trigger_mode='auto'<CR>", { noremap = true })

-- Disable Tabby completion (set to manual mode)
vim.api.nvim_set_keymap('n', '<leader>td', ":let g:tabby_trigger_mode='manual'<CR>", { noremap = true })

vim.api.nvim_set_keymap('n','<leader>ce', ":let g:tabby_trigger_mode='auto'<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cd', ":let g:tabby_trigger_mode='manual'<CR>", { noremap = true })



