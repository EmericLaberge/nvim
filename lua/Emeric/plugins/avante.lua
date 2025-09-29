return {
  "yetone/avante.nvim",
  build = "make BUILD_FROM_SOURCE=true",
  lazy = false,
  version = false,
  BUILD_FROM_SOURCE = true,
  config = function()
    require("avante_lib").load()
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "HakonHarnes/img-clip.nvim",
  },
}
