return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'echasnovski/mini.nvim', opt = true },
  config = function()
    require('render-markdown').setup({})
  end,
}