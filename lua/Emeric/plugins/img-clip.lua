return {
  'HakonHarnes/img-clip.nvim',
  config = function()
    require('img-clip').setup({
    })
    vim.keymap.set('n', '<leader>p', '<cmd>PasteImage<cr>', { desc = 'Paste image from system clipboard' })
  end,
}