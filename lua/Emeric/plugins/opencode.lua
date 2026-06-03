return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts

    -- Configure MiniMax provider for opencode
    -- WARNING: These set global ANTHROPIC_* env vars which may affect other plugins
    local minimax_key = os.getenv("MINIMAX_KEY")
    if minimax_key and minimax_key ~= "" then
      vim.env.ANTHROPIC_AUTH_TOKEN = minimax_key
      vim.env.ANTHROPIC_BASE_URL = "https://api.minimax.io/anthropic"
      vim.env.ANTHROPIC_MODEL = "MiniMax-M2.5"
    else
      vim.notify("MINIMAX_KEY not set. Opencode will use default provider.", vim.log.levels.WARN)
    end

    vim.g.opencode_opts = {
      model = "minimax/MiniMax-M2.5",
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "opencode: Ask" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "opencode: Select action" })
    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "opencode: Toggle" })
  end,
}