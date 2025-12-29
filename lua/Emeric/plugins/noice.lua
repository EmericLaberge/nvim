return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- Remplacement des handlers natifs par ceux de Noice
        hover = {
          enabled = true, -- Active le hover stylisé par Noice
          silent = true, -- Ne pas afficher de message si pas de doc dispo
        },
        signature = {
          enabled = true, -- Affiche aussi la signature de fonction stylisée
        },
        -- override markdown rendering so that **cmp** and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- Préréglages recommandés pour une expérience fluide
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true, -- Ajoute une bordure aux docs (hover)
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
  end,
}

