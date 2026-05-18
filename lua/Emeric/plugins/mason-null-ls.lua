return {
  "williamboman/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
        "isort",
        "yapf",
        "prettier",
        "perltidy",
        "sqlfluff",
        "latexindent",
      },
      automatic_installation = false,
      automatic_confirmation = false,
    })
  end,
}