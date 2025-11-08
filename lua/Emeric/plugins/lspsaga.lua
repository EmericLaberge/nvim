return {
  "glepnir/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
				code_action = "",
			},
			hover = {
				enabled = false,
			},
		})
	end,
}