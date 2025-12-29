return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        -- !!! ADD THIS SECTION !!!
        -- This ensures nvim-lint, conform, and other plugins can find tools installed by Mason
        local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
        vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
        -- !!! END ADDITION !!!

        -- Simple, robust mason + mason-lspconfig setup.
        local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
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
        if ok and type(lsp_setup.servers) == "table" then servers = lsp_setup.servers end

        require("mason").setup()

        local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
        if ok_mlsp and mlsp and type(mlsp.setup) == "function" then
            local opts = { automatic_installation = true }
            if #servers > 0 then opts.ensure_installed = servers end
            pcall(mlsp.setup, opts)

            -- Use vim.lsp.config instead of require('lspconfig') for Neovim 0.11+
            -- Fallback to require('lspconfig') for older versions
            local lspconfig
            if vim.lsp and vim.lsp.config then
                lspconfig = vim.lsp.config
            else
                local ok_lsp, lspconfig_req = pcall(require, "lspconfig")
                if ok_lsp then
                    lspconfig = lspconfig_req
                end
            end

            if lspconfig then
                for _, srv in ipairs(servers) do
                    local cfg = {}
                    if ok and type(lsp_setup.on_attach) == "function" then
                        cfg.on_attach = lsp_setup.on_attach
                    end
                    if ok and type(lsp_setup.lsp_flags) == "table" then
                        cfg.flags = lsp_setup.lsp_flags
                    end

                    if lspconfig[srv] and type(lspconfig[srv].setup) == "function" then
                        local setup_ok, setup_err = pcall(lspconfig[srv].setup, cfg)
                        if not setup_ok then
                            vim.notify("Failed to setup LSP server: " .. srv .. " - " .. tostring(setup_err), vim.log.levels.WARN)
                        end
                    end
                end
            end
        else
            vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
        end
    end,
}
