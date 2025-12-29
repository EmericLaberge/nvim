return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Configuration des linters par type de fichier
    lint.linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- Python
      python = { "pylint", "ruff" },
      -- Lua
      lua = { "luacheck" },
      -- Shell
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      -- YAML
      yaml = { "yamllint" },
      -- JSON
      json = { "jsonlint" },
      -- Markdown
      markdown = { "markdownlint" },
      -- Docker
      dockerfile = { "hadolint" },
      -- SQL
      sql = { "sqlfluff" },
    }

    -- Fonction pour lancer le linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Linter automatiquement à l'ouverture, après écriture et en quittant l'insertion
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Commande manuelle pour forcer le linting
    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, { desc = "Run linters for current buffer" })
  end,
}
