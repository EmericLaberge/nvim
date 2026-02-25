return {
  "jbyuki/nabla.nvim",
  keys = {
    {
      "<leader>np",
      function()
        require("nabla").popup()
      end,
      desc = "Nabla preview equation",
    },
  },
  config = function()
    require("nabla").setup({
      border = "rounded",
    })
  end,
}
