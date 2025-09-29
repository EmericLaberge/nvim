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
  },
  config = function()
		local on_attach = function(client, bufnr)
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

		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Diagnostics Float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go To Previous Diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go To Next Diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set Diagnostics Loclist" })

		local servers = {
			"bashls",
			"cssls",
			"dockerls",
			"gopls",
			"html",
			"jdtls",
			"jsonls",
			"lua_ls",
			"perlnavigator",
			"phpactor",
			"pyright",
			"rust_analyzer",
			"scheme_langserver",
			"tsserver",
			"yamlls",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		local lsp_flags = {
			debounce_text_changes = 150,
		}

		require("mason-lspconfig").setup_handlers({
			function(server_name) -- default handler (for servers that don't have special options)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					flags = lsp_flags,
				})
			end,
			["jdtls"] = function()
				-- jdtls requires a data directory per project.
			end,
			["phpactor"] = function()
				require("lspconfig").phpactor.setup({
					on_attach = on_attach,
					flags = lsp_flags,
					init_options = {
						["language_server_phpstan.enabled"] = false,
						["language_server_psalm.enabled"] = false,
					},
				})
			end,
		})

		local function get_active_lsp_client()
			local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
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
