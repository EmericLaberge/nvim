-- Script pour installer tous les outils Mason
-- À exécuter dans Neovim: :source install_all_tools.lua

local function install_mason_tools()
  local tools = {
    -- LSP Servers
    "bash-language-server",
    "clangd",
    "csharp-language-server",
    "css-lsp",
    "dockerfile-language-server",
    "gopls",
    "html-lsp",
    -- "jdtls",
    "json-lsp",
    "lua-language-server",
    "marksman",
    "omnisharp",
    "perlnavigator",
    "phpactor",
    "basedpyright",
    "rust-analyzer",
    "sqls",
    "texlab",
    "typescript-language-server",
    "yaml-language-server",
    -- Formatters
    "stylua",
    "isort",
    "black",
    "prettier",
    "sqlfluff",
    -- Linters
    "eslint_d",
    "pylint",
    "ruff",
    "luacheck",
    "shellcheck",
    "yamllint",
    "jsonlint",
    "markdownlint",
    "hadolint",
  }

  print("🚀 Installation de " .. #tools .. " outils via Mason...")
  
  for i, tool in ipairs(tools) do
    vim.cmd("MasonInstall " .. tool)
    print(string.format("[%d/%d] %s", i, #tools, tool))
    vim.wait(500)
  end
  
  print("✅ Commandes d'installation envoyées!")
  print("💡 Surveillez :Mason pour voir la progression")
end

install_mason_tools()
