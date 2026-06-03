return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange }
        -- INFO TECHNIQUE :
        -- BG Storm normal = #24283b
        -- Notre BG subtil = #222639 (C'est vraiment une différence infime)
        local subtle_bg = "none"
        -- Couleur de fond de l'onglet actif (plus clair ou coloré)
        local active_bg = "none"

        -- 1. Fond de la barre vide
        hl.BufferTabpageFill = { bg = subtle_bg }
        hl.BufferOffset = { bg = subtle_bg }

        -- 2. Onglet ACTIF (Coins arrondis)
        hl.BufferCurrent = { bg = active_bg, fg = c.info, bold = true }
        hl.BufferCurrentIcon = { bg = active_bg, fg = c.info }
        hl.BufferCurrentMod = { bg = active_bg, fg = c.warning }
        hl.BufferCurrentSign = { bg = active_bg, fg = c.info }

        -- 3. Onglets INACTIFS (Coins arrondis)
        hl.BufferInactive = { bg = subtle_bg, fg = c.comment }
        hl.BufferInactiveIcon = { bg = subtle_bg, fg = c.comment }
        hl.BufferInactiveMod = { bg = subtle_bg, fg = c.warning }
        hl.BufferInactiveSign = { bg = subtle_bg, fg = c.comment }

        -- 4. Onglets VISIBLES (mais pas actifs)
        hl.BufferVisible = { bg = subtle_bg, fg = c.fg }
        hl.BufferVisibleIcon = { bg = subtle_bg, fg = c.fg }
        hl.BufferVisibleMod = { bg = subtle_bg, fg = c.warning }
        hl.BufferVisibleSign = { bg = subtle_bg, fg = c.info }

        -- 5. DROPBAR
        hl.WinBar = { bg = subtle_bg, fg = c.fg }
        hl.WinBarNC = { bg = subtle_bg, fg = c.comment }
      end,
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
