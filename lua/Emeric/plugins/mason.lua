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
	end,
}
