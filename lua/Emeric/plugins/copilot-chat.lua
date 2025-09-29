return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  build = "make tiktoken", -- Build step for tiktoken (MacOS/Linux)
  config = function()
    local ok, cc = pcall(require, "CopilotChat")
    if ok and cc and cc.setup then
      cc.setup({})
    end
  end,
}