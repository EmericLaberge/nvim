return {
  "rebelot/avante.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("avante").setup({
      provider = "ollama",
      ollama = {
        model = "llama3.1:latest",
      }
    })
  end,
}
