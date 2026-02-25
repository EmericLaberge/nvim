return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    local diag = require("tiny-inline-diagnostic")
    diag.setup({
      -- Choose a preset style for diagnostic appearance
      preset = "modern",

      -- Make diagnostic background transparent
      transparent_bg = false,

      -- Make cursorline background transparent for diagnostics
      transparent_cursorline = true,

      -- Pas d'underline pour les diagnostics (juste le texte à la fin)
      underline = false,

      -- Couleurs subtiles pour le texte
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "Normal",
      },

      -- List of filetypes to disable the plugin for
      disabled_ft = {},

      -- Custom signs (overrides preset signs)
      options = {
        show_source = {
          enabled = false,
          if_many = false,
        },

        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = false,
        throttle = 20,
        softwrap = 30,

        add_messages = {
          messages = true,
          display_count = false,
          use_max_severity = false,
          show_multiple_glyphs = true,
        },

        multilines = {
          enabled = false,
          always_show = false,
          trim_whitespaces = false,
          tabstop = 4,
          severity = nil,
        },

        show_all_diags_on_cursorline = false,
        show_diags_only_under_cursor = false,

        show_related = {
          enabled = true,
          max_count = 3,
        },

        enable_on_insert = false,
        enable_on_select = false,

        overflow = {
          mode = "wrap",
          padding = 0,
        },

        break_line = {
          enabled = false,
          after = 30,
        },

        format = nil,

        virt_texts = {
          priority = 2048,
        },

        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },

        overwrite_events = nil,
        override_open_float = false,

        experimental = {
          use_window_local_extmarks = false,
        },
      },
    })

    -- Désactivé - l'utilisateur ne veut pas de diagnostics inline
    diag.disable()
  end,
}
