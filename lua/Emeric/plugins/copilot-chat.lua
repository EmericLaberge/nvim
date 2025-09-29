return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  build = "make tiktoken", -- Build step for tiktoken (MacOS/Linux)
  config = function()
    require("CopilotChat").setup({
    })
  end,
}