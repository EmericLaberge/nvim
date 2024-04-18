-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Global mappings. See `:help vim.diagnostic.*` for documentation on any of the below functions vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev){desc = 'Go to previous diagnostic'}
vim.keymap.set('n', ']d', vim.diagnostic.goto_next) {desc = 'Go to next diagnostic'}
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist) {desc = 'Set loclist'}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) { desc = 'Go to declaration'}
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) { desc = 'Go to definition'}
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) { desc = 'Show hover'}
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) { desc = 'Go to implementation'}
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) { desc = 'Show signature help'}
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts) { desc = 'Add workspace folder'}
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts) { desc = 'Remove workspace folder'} 
    vim.keymap.set('n', '<space>wl', function() 
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts) { desc = 'List workspace folders'}
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts) { desc = 'Go to type definition'}
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts) { desc = 'Rename'}
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts) { desc = 'Code action'}
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) { desc = 'Go to references'}
    vim.keymap.set('n', '<space>f', function() 
      vim.lsp.buf.format { async = true }
    end, opts) { desc = 'Format'}
  end,
})
