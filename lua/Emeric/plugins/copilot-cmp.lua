return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", "nvim-cmp" },
  config = function()
    -- copilot-cmp registers a source named 'copilot' for nvim-cmp. Configure
    -- it with reasonable defaults so it plays nicely with other sources.
    require("copilot_cmp").setup({
      method = "getCompletionsCycling",
      -- Optionally debounce to reduce churn
      debounce = 75,
    })
  end,
}