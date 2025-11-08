return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
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
		if ok and type(lsp_setup.servers) == "table" then servers = lsp_setup.servers end

		require("mason").setup()

		local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
		if ok_mlsp and mlsp and type(mlsp.setup) == "function" then
			local opts = { automatic_installation = true }
			if #servers > 0 then opts.ensure_installed = servers end
			pcall(mlsp.setup, opts)

			local ok_lsp, lspconfig = pcall(require, "lspconfig")
			for _, srv in ipairs(servers) do
				local cfg = {}
				if ok and type(lsp_setup.on_attach) == "function" then
					cfg.on_attach = lsp_setup.on_attach
				end
				if ok and type(lsp_setup.lsp_flags) == "table" then
					cfg.flags = lsp_setup.lsp_flags
				end

				if ok_lsp and lspconfig and lspconfig[srv] and type(lspconfig[srv].setup) == "function" then
					pcall(lspconfig[srv].setup, cfg)
				end
			end
		else
			vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
		end
	end,
}
