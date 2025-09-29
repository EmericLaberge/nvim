return {
  "TabbyML/vim-tabby",
  config = function()
    vim.g.tabby_agent_start_command = { "npx", "tabby-agent", "--stdio" }
    vim.g.tabby_inline_completion_trigger = "manual"
    vim.g.tabby_inline_completion_keybinding_accept = "<A-Space>"
    vim.api.nvim_set_keymap('n', '<leader>te', ":let g:tabby_inline_completion_trigger='auto'<CR>",
      { noremap = true, silent = true, desc = " Enable Tabby " })
    vim.api.nvim_set_keymap('n', '<leader>td', ":let g:tabby_inline_completion_trigger='manual'<CR>",
      { noremap = true, silent = true, desc = " Disable Tabby " })
  end,
}
