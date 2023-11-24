local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  -- 'jdtls', -- This line is removed or commented out to remove jdtls
  -- other LSP servers
})

-- Configure Lua LSP server
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- ... other LSP server configurations for Python, etc ...

-- CMP configuration
-- ... (rest of your cmp configuration)

-- Set general LSP preferences
-- ... (rest of your lsp preferences)

-- General on_attach function for LSP servers
-- ... (rest of your on_attach configuration)

-- Apply the LSP settings
lsp.setup()

-- Diagnostic virtual text configuration
vim.diagnostic.config({
    virtual_text = true,
})

-- You can remove the autocommand for jdtls if you no longer need it
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'java',
--   callback = function()
--     -- Your previous jdtls setup would have been here
--   end,
-- })

