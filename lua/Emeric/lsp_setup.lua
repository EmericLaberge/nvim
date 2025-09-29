local M = {}

M.servers = {
    "bashls",
    "clangd",
    "csharp_ls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "julials",
    "lua_ls",
    "marksman",
    "omnisharp",
    "perlnavigator",
    "phpactor",
    "pyright",
    "rust_analyzer",
    "sqls",
    "texlab",
    "ts_ls",
    "yamlls",
}

M.lsp_flags = {
    debounce_text_changes = 150,
}

M.on_attach = function(client, bufnr)
    local builtin = require("telescope.builtin")
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr, desc = "Go To Definition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr, desc = "Go To References" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = bufnr, desc = "Go To Implementation" })
    vim.keymap.set("n", "<space>D", builtin.lsp_type_definitions, { buffer = bufnr, desc = "Go To Type Definition" })
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { buffer = bufnr, desc = "Workspace Symbols" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go To Declaration" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = "Format Code" })
end

return M
