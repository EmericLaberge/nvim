local M = {}

-- Noice.nvim gère maintenant le hover, pas besoin de handler personnalisé
-- Le handler est géré par noice.lua dans la section lsp.hover

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
  "lua_ls",
  "marksman",
  "omnisharp",
  "perlnavigator",
  "phpactor",
  "pyright",
  "ruff",
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
  vim.keymap.set("n", "<leader>dg", builtin.diagnostics, { buffer = bufnr, desc = "Telescope Diagnostics (All)" })
  vim.keymap.set("n", "<leader>dG", function()
    builtin.diagnostics({ bufnr = 0 })
  end, { buffer = bufnr, desc = "Telescope Diagnostics (Buffer)" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go To Declaration" })
  -- Utiliser vim.lsp.buf.hover - Noice.nvim interceptera automatiquement pour un rendu moderne
  -- Noice affiche uniquement la documentation LSP (pas de diagnostics)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
  vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
  -- vim.keymap.set("n", "<space>f", function()
  --     vim.lsp.buf.format({ async = true })
  -- end, { buffer = bufnr, desc = "Format Code" })
end

-- Désactivation du surlignage automatique pour éviter les surlignages indésirables
-- Les keymaps K, gd, gr utilisent Telescope et n'ont pas besoin de surlignage automatique

return M
