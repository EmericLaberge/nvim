return {
  "crnvl96/lazydocker.nvim",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>ld', ':LazyDocker<CR>', { noremap = true, silent = true })
  end,
}
