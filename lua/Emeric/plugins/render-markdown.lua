return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    require("markview").setup({
      preview = {
        icon_provider = "internal",
      },

      latex = {
        enable = true,

        blocks = {
          enable = true,
          hl = "MarkviewCode",
          pad_char = " ",
          pad_amount = 3,
          text = " LaTeX ",
          text_hl = "MarkviewCodeInfo"
        },

        commands = {
          enable = true,
        },

        inlines = {
          enable = true,
          padding_left = " ",
          padding_right = " ",
          hl = "MarkviewInlineCode"
        },

        subscripts = { enable = true },
        superscripts = { enable = true },

        fonts = {
          enable = true,
          default = { enable = true },
          mathbb = { enable = true },
          mathcal = { enable = true },
        },

        escapes = { enable = true },
        parenthesis = { enable = true },
        symbols = { enable = true },
        texts = { enable = true }
      }
    })

    -- Extras
    require("markview.extras.checkboxes").setup({
      default = "X",
      remove_style = "disable",
    })

    require("markview.extras.headings").setup()

    require("markview.extras.editor").setup()

    -- Checkbox keymaps
    -- <leader>c + key = checkbox action (mnemonic: c for checkbox)
    vim.keymap.set("n", "<leader>ct", "<cmd>Checkbox toggle<cr>", { desc = "Checkbox toggle" })
    vim.keymap.set("n", "<leader>cx", "<cmd>Checkbox change 2 0<cr>", { desc = "Checkbox [X] (check)" })
    vim.keymap.set("n", "<leader>c0", "<cmd>Checkbox change 0 0<cr>", { desc = "Checkbox [ ] (uncheck)" })

    vim.keymap.set("n", "<leader>ci", "<cmd>Checkbox interactive<cr>", { desc = "Checkbox interactive" })
  end,
}
