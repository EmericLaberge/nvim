return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local hooks = require "ibl.hooks"

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Couleurs style NVChad - gris discret
      vim.api.nvim_set_hl(0, "IblIndent", {
        fg = "#3B4048",
      })
      vim.api.nvim_set_hl(0, "IblScope", {
        fg = "#7AA2F7",
        bold = true,
      })
    end)

    require("ibl").setup {
      indent = {
        char = "│",
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = "IblScope",
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "lazy",
          "mason",
          "Trouble",
          "telescope",
          "nofile",
          "quickfix",
        },
      },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
