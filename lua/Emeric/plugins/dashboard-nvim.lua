return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local db = require("dashboard")
    db.setup({
      theme = "hyper",
      config = {
        header = {
          'Hello, Emeric!'
        },
        center = {
          {
            icon = ' ',
            desc = 'Find File',
            key = 'f',
            action = 'Telescope find_files'
          },
          {
            icon = ' ',
            desc = 'Recently Used Files',
            key = 'r',
            action = 'Telescope oldfiles'
          },
          {
            icon = ' ',
            desc = 'Load Last Session',
            key = 's',
            action = 'SessionLoad'
          },
          {
            icon = ' ',
            desc = 'Find Word',
            key = 'g',
            action = 'Telescope live_grep'
          },
          {
            icon = ' ',
            desc = 'Marks',
            key = 'm',
            action = 'Telescope marks'
          }
        },
        footer = {'Neovim loaded for Emeric!'}
      }
    })
  end,
}
