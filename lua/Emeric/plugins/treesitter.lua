return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ignore_install = { "help" },
      	ensure_installed = {
		"javascript",
		"typescript",
		"c",
		"lua",
		"rust",
		"python",
		"json",
		"html",
		"css",
		"java",
		"bash",
		"haskell",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"make",
		"jsonc",
		"yaml",
		"cpp",
		"vim",
		"vimdoc",
		"query",
	},
      sync_install = true,
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      highlight = {
        enable = true,
        disable = {"latex"},
        additional_vim_regex_highlighting = { "latex", "markdown" },
      },
    }
  end,
}
