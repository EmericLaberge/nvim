return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				-- require('hover.providers.dap')
				-- require('hover.providers.man')
				-- require('hover.providers.dictionary')
			end,
			preview_opts = {
				border = "rounded",
			},
			-- Whether the contents of a single provider can be previewed
			-- together in a single floating window.
			preview_multiple = true,
			-- Whether floating windows are automatically focusable
			focusable = false,
			title = false,
		})
	end,
}
