return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go To Declaration" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go To Definition" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go To Implementation" })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature Help" })
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { desc = "List Workspace Folders" })
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Go To Type Definition" })
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go To References" })
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, { desc = "Format Code" })
    end
  end,
}
