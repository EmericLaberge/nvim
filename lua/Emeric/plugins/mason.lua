-- return {
--     "williamboman/mason.nvim",
--     dependencies = { "williamboman/mason-lspconfig.nvim" },
--     config = function()
--         -- !!! ADD THIS SECTION !!!
--         -- This ensures nvim-lint, conform, and other plugins can find tools installed by Mason
--         local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
--         vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
--         -- !!! END ADDITION !!!
--
--         local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--         -- Simple, robust mason + mason-lspconfig setup.
--         local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
--         local servers = {
--             "bashls",
--             "clangd",
--             "cssls",
--             "dockerls",
--             "gopls",
--             "html",
--             "jsonls",
--             "lua_ls",
--             "marksman",
--             "omnisharp",
--             "perlnavigator",
--             "phpactor",
--             "pyright",
--             "rust_analyzer",
--             "sqls",
--             "texlab",
--             "ts_ls",
--             "yamlls",
--         }
--         if ok and type(lsp_setup.servers) == "table" then servers = lsp_setup.servers end
--
--         require("mason").setup()
--
--         local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
--         if ok_mlsp and mlsp and type(mlsp.setup) == "function" then
--             local opts = { automatic_installation = true }
--             if #servers > 0 then opts.ensure_installed = servers end
--             pcall(mlsp.setup, opts)
--
--             local has_lspconfig, lspconfig_plugin = pcall(require, "lspconfig")
--
--             for _, srv in ipairs(servers) do
--                 local cfg = {
--                     capabilities = capabilities,
--                 }
--                 if ok and type(lsp_setup.on_attach) == "function" then
--                     cfg.on_attach = lsp_setup.on_attach
--                 end
--                 if ok and type(lsp_setup.lsp_flags) == "table" then
--                     cfg.flags = lsp_setup.lsp_flags
--                 end
--
--                 -- Neovim 0.11+ support
--                 if vim.lsp.config and type(vim.lsp.config) == "function" then
--                     local setup_ok, setup_err = pcall(function()
--                         vim.lsp.config(srv, cfg)
--                         vim.lsp.enable(srv)
--                     end)
--                     if not setup_ok then
--                         vim.notify("Failed to setup LSP server (v0.11): " .. srv .. " - " .. tostring(setup_err), vim.log.levels.WARN)
--                     end
--                 -- Fallback to nvim-lspconfig
--                 elseif has_lspconfig and lspconfig_plugin[srv] then
--                     local setup_ok, setup_err = pcall(lspconfig_plugin[srv].setup, cfg)
--                     if not setup_ok then
--                         vim.notify("Failed to setup LSP server: " .. srv .. " - " .. tostring(setup_err), vim.log.levels.WARN)
--                     end
--                 end
--             end
--         else
--             vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
--         end
--     end,
-- }
return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    -- 1. Ajout au PATH pour que les outils Mason soient visibles (linters, formatters)
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

    -- 2. Configuration des capacités (autocomplétion)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- 3. Chargement de tes préférences (on_attach, flags) depuis lsp_setup.lua
    local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
    if not ok then
      lsp_setup = { on_attach = nil, lsp_flags = {} }
    end

    -- 4. Liste des serveurs (J'ai retiré jdtls comme demandé)
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
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
    
    -- Si tu as défini une liste dans lsp_setup, on l'utilise
    if ok and lsp_setup.servers then
      servers = lsp_setup.servers
    end

    -- 5. Setup de Mason
    require("mason").setup()

    -- 6. Setup de Mason-LSPConfig avec les HANDLERS (La correction est ici)
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
      handlers = {
        -- Handler par défaut : s'applique à tous les serveurs installés
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = lsp_setup.on_attach,
            flags = lsp_setup.lsp_flags,
          })
        end,
        -- Tu peux ajouter des exceptions ici si nécessaire, par exemple :
        -- ["lua_ls"] = function() ... end
      }
    })
  end,
}
