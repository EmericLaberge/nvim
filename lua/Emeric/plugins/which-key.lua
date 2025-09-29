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
      triggers = { "<leader>", "<localleader>" },
      show_help = true,
      show_keys = true,
      disable = {
        buftypes = {},
        filetypes = {},
      },
    })
    -- local vimtex_mappings = {
    --   { "<localleader>",   group = "Vimtex" },
    --   { "<localleader>a",  desc = "Context Menu" },
    --   { "<localleader>c",  group = "Clean" },
    --   { "<localleader>cC", desc = "Clean Full" },
    --   { "<localleader>cc", desc = "Clean Aux Files" },
    --   { "<localleader>e",  desc = "View Errors" },
    --   { "<localleader>g",  group = "Status" },
    --   { "<localleader>gG", desc = "Show Full Status" },
    --   { "<localleader>gg", desc = "Show Status" },
    --   { "<localleader>i",  group = "Info" },
    --   { "<localleader>iI", desc = "Show Full Info" },
    --   { "<localleader>ii", desc = "Show Info" },
    --   { "<localleader>k",  group = "Stop" },
    --   { "<localleader>kK", desc = "Stop All" },
    --   { "<localleader>kk", desc = "Stop Compilation" },
    --   { "<localleader>l",  group = "Compile" },
    --   { "<localleader>lL", desc = "Compile Selection" },
    --   { "<localleader>ll", desc = "Compile" },
    --   { "<localleader>lo", desc = "Compiler Output" },
    --   { "<localleader>m",  desc = "List Imaps" },
    --   { "<localleader>q",  desc = "Show Log" },
    --   { "<localleader>s",  desc = "Set as Main File" },
    --   { "<localleader>t",  group = "TOC" },
    --   { "<localleader>tT", desc = "Toggle TOC" },
    --   { "<localleader>tt", desc = "Open Table of Contents" },
    --   { "<localleader>v",  desc = "View PDF" },
    --   { "<localleader>x",  desc = "Reload" },
    -- }
    -- require("which-key").register(vimtex_mappings)
  end,
}
