return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "rachartier/tiny-code-action.nvim",
    },
    config = function()
        -- =========================================================
        -- 1. Configuration des diagnostics (virtual text seulement)
        -- =========================================================

        -- =========================================================
        -- 1. Configuration des diagnostics (signs seulement)
        -- =========================================================

        -- Cercles remplis de couleur pour les diagnostics
        vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#F7768E", bg = "none" })   -- rouge rempli
        vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#E0AF68", bg = "none" })    -- orange
        vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#7AA2F7", bg = "none" })    -- bleu
        vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#9ECE6A", bg = "none" })    -- vert

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰍵",
                    [vim.diagnostic.severity.WARN] = "󰀦",
                    [vim.diagnostic.severity.HINT] = "󰌶",
                    [vim.diagnostic.severity.INFO] = "󰋼",
                },
            },
            underline = false,
            virtual_text = false,
            severity_sort = true,
            update_in_insert = false,
        })

        -- =========================================================
        -- 2. Chargement de la config personnalisée
        -- =========================================================
        local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
        if not ok then
            vim.notify("Emeric.lsp_setup not found; LSP keymaps may be incomplete", vim.log.levels.WARN)
            return
        end

        local on_attach = lsp_setup.on_attach
        local lsp_flags = lsp_setup.lsp_flags

        -- Utiliser LspAttach pour s'assurer que on_attach est appelé pour TOUS les clients LSP
        local lsp_attach_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_attach_group,
            callback = function(event)
                on_attach(event.data.client, event.buf)
            end,
        })

        -- Appliquer on_attach aux clients LSP déjà attachés
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local clients = vim.lsp.get_clients({ bufnr = buf })
            if #clients > 0 then
                for _, client in ipairs(clients) do
                    on_attach(client, buf)
                end
            end
        end

        -- Diagnostics keymaps
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Diagnostics Float" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go To Previous Diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go To Next Diagnostic" })
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set Diagnostics Loclist" })

        -- Helper to show active client
        local function get_active_lsp_client()
            local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
            if #clients == 0 then
                return nil
            else
                return clients[1]
            end
        end

        local function print_active_lsp_client()
            local client = get_active_lsp_client()
            if client then
                print("Active LSP client: " .. client.name)
            else
                print("No active LSP client")
            end
        end

        vim.keymap.set("n", "<space>lp", print_active_lsp_client, { desc = "Print Active LSP Client" })
    end,
}
