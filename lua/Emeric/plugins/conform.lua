return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        perl = { 'perltidy' },
        python = { 'black' },
        sql = { 'sqlfluff' },
      },
      formatters = {
        sqlfluff = {
          command = 'sqlfluff',
          args = { 'format', '--dialect=postgres', '-' },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { noremap = true, desc = 'Format file or selection' })
  end,
}
