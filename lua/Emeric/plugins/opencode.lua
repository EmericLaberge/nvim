return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

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
