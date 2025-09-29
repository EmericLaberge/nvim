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
		local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
		if not ok then
			vim.notify("Emeric.lsp_setup not found; LSP keymaps may be incomplete", vim.log.levels.WARN)
			return
		end

		local on_attach = lsp_setup.on_attach
		local lsp_flags = lsp_setup.lsp_flags

		-- Diagnostics keymaps
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Diagnostics Float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go To Previous Diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go To Next Diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set Diagnostics Loclist" })

		-- helper to show active client
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