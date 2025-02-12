local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    perl = { 'perltidy' },
    python = { 'black' },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_format = "fallback",
  -- }
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { noremap = true, desc = 'Format file' })
