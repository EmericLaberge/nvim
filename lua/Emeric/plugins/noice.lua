return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      notify = {
        enabled = false,
      },
      lsp = {
        hover = {
          enabled = true,
          silent = true,
          -- Enlever le bold du hover
          opts = {
            border = "rounded",
            focusable = false,
          },
        },
        signature = {
          enabled = true,
          opts = {
            border = "rounded",
          },
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },
      },
    })

    -- Réduire l'intensité du highlight LSP
    -- Utiliser ColorScheme pour appliquer après le thème
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#7AA2F7", bg = "#2A2E3E", bold = false, italic = false, nocombine = true })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#7AA2F7", bg = "#2A2E3E", bold = false, italic = false, nocombine = true })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#7AA2F7", bg = "#2A2E3E", bold = false, italic = false, nocombine = true })
      end,
    })
  end,
}

