local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    perl = { 'perltidy' },
    python = { 'black' },
    -- Add SQL formatting here:
    sql = { 'sqlfluff' }, -- Or use 'pg_format', 'prettier', etc.
    -- You can even specify multiple formatters to run sequentially
    -- sql = { 'sqlfluff', 'another_formatter' },
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
  -- format_on_save is currently commented out. Uncomment if you want format on save:
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = "fallback", -- Use "fallback" or true if you prefer LSP as a backup
  -- }
})

-- This keymap will now also work for SQL files after adding the formatter above
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({
    lsp_fallback = true, -- Tries LSP if conform formatter fails
    async = false,       -- Formatting will block until complete
    timeout_ms = 500,   -- Max time for the formatter to run
  })
end, { noremap = true, desc = 'Format file or selection' }) -- Updated desc slightly
