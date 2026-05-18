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
    {
      "<leader>vl",
      function()
        require("nabla").toggle_virt()
      end,
      desc = "Toggle Nabla virtual lines",
    },
  },
}
