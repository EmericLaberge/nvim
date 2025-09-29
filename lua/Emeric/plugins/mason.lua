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
		else
			vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
		end

		-- Minimal server configuration: try lspconfig first, then the new vim.lsp.config API
		local ok_lsp, lspconfig = pcall(require, "lspconfig")
		for _, srv in ipairs(servers) do
			local cfg = {}
			if ok and type(lsp_setup.on_attach) == "function" then cfg.on_attach = lsp_setup.on_attach end
			if ok and type(lsp_setup.lsp_flags) == "table" then cfg.flags = lsp_setup.lsp_flags end

			local configured = false
			if ok_lsp and lspconfig and lspconfig[srv] and type(lspconfig[srv].setup) == "function" then
				local ok2 = pcall(lspconfig[srv].setup, cfg)
				if ok2 then configured = true end
			end

			if not configured and vim.lsp and vim.lsp.config and type(vim.lsp.config.setup_default) == "function" then
				local ok2 = pcall(vim.lsp.config.setup_default, srv, cfg)
				if ok2 then configured = true end
			end

			if not configured then
				vim.notify("mason: could not configure LSP server '" .. tostring(srv) .. "'", vim.log.levels.WARN)
			end
		end
	end,
}
