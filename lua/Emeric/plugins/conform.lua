return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        -- Utilisez "isort" puis "black" pour Python
        python = { "isort", "black" },
        -- Web (JS/TS/HTML/CSS) avec Prettier
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        -- Formateurs personnalisés existants
        perl = { "perltidy" },
        sql = { "sqlfluff" },
        -- LaTeX avec latexindent
        tex = { "latexindent" },
        latex = { "latexindent" },
      },
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          args = { "format", "--dialect=postgres", "-" },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        latexindent = {
          command = "latexindent",
          args = { "-" },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
      -- Formatage lors de la sauvegarde (optionnel, commentez si vous ne voulez que le manuel)
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 1000,
      -- },
    })

    -- Définition de la touche <leader>f
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      local ok, err = pcall(function()
        conform.format({
          lsp_fallback = true, -- Utilise le LSP si aucun formateur n'est dispo (ex: clangd pour C++)
          async = false,
          timeout_ms = 1000,
        })
      end)
      if not ok then
        vim.notify("Erreur de formatage: " .. tostring(err), vim.log.levels.ERROR)
      end
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
