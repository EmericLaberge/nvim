return {
  "nvim-tree/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.g.dashboard_default_executive = 'telescope'

    vim.g.dashboard_custom_header = {
      'Hello, Emeric!'
    }

    vim.g.dashboard_custom_section = {
      a = { description = { '  Find File          ' }, command = 'Telescope find_files' },
      b = { description = { '  Recently Used Files' }, command = 'Telescope oldfiles' },
      c = { description = { '  Load Last Session  ' }, command = 'SessionLoad' },
      d = { description = { '  Find Word          ' }, command = 'Telescope live_grep' },
      e = { description = { '  Marks              ' }, command = 'Telescope marks' }
    }

    vim.g.dashboard_custom_footer = {'Neovim loaded for Emeric!'}
  end,
}
