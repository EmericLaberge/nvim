return {
  'richwomanbtc/overleaf.nvim',
  cmd = 'Overleaf',
  build = 'cd node && npm install',
  config = function()
    require('overleaf').setup({
      keys = false, -- Disable default keymaps, we'll use neo-tree
    })
  end,
}
