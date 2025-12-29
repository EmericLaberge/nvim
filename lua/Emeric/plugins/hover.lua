return {
	"lewis6991/hover.nvim",
	enabled = false, -- Désactivé, on utilise noice.nvim pour le hover
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers - SEULEMENT LSP, pas de diagnostics
				require("hover.providers.lsp")
				-- Ne PAS charger 'hover.providers.diagnostic'
				-- require('hover.providers.dap')
				-- require('hover.providers.man')
				-- require('hover.providers.dictionary')
				-- require('hover.providers.gh') -- Github
				-- require('hover.providers.gh_user') -- Github User
			end,
			preview_opts = {
				border = "rounded",
			},
			-- Whether the contents of a single provider can be previewed
			-- together in a single floating window.
			preview_multiple = true,
			-- Whether floating windows are automatically focusable
			focusable = false,
			title = true,
			-- Filtrer les providers pour n'afficher que LSP (pour la souris)
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 1000,
		})
		
		-- Désactiver le hover natif du LSP pour éviter les doublons
		-- (le handler dans lsp_setup.lua gère déjà le rendu)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})
	end,
}
