return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      -- Set triggers to a minimal safe set. Using only <leader> avoids which-key
      -- validation errors while still enabling leader-key popups. Add more
      -- prefixes later if needed (careful with which-key's validation rules).
      -- triggers = { "<leader>", "\\" },
      show_help = true,
      show_keys = true,
      disable = {
        buftypes = {},
        filetypes = {},
      },
    })
    vim.keymap.set(
      "n",
      "<localleader>?",
      ":lua print(string.format('localleader is %s', vim.g.maplocalleader))<CR>",
      { desc = "print localleader" }
    )
  end,
}
