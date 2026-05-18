local PROVIDER_SCRIPTS = {
  anthropic = os.getenv("CLAUDE_PROVIDER_ANTHROPIC"),
  minimax = os.getenv("CLAUDE_PROVIDER_MINIMAX"),
  anthropic_yolo = os.getenv("CLAUDE_PROVIDER_ANTHROPIC_YOLO"),
  minimax_yolo = os.getenv("CLAUDE_PROVIDER_MINIMAX_YOLO"),
}

local choices = {
  { id = "anthropic", label = "Anthropic (default)", desc = "Sonnet/Opus models" },
  { id = "minimax", label = "MiniMax (M2.5)", desc = "MiniMax M2.5 model" },
  { id = "anthropic_yolo", label = "Anthropic YOLO", desc = "Skip permissions" },
  { id = "minimax_yolo", label = "MiniMax YOLO", desc = "Skip permissions" },
}

local function start_claude(provider)
  local script = PROVIDER_SCRIPTS[provider]
  if not script then
    vim.notify("Unknown provider: " .. provider, vim.log.levels.ERROR)
    return
  end

  local claude_code = require("claude-code")
  claude_code.config.command = script
  claude_code.toggle()
end

local function choose_claude_provider()
  vim.ui.select(choices, {
    prompt = "Choose Claude provider:",
    format_item = function(item)
      return item.label .. " - " .. item.desc
    end,
  }, function(choice)
    if choice then
      start_claude(choice.id)
    end
  end)
end

return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>cc", choose_claude_provider, desc = "Claude Code (choose provider)" },
    { "<leader>cca", function() start_claude("anthropic") end, desc = "Claude Anthropic" },
    { "<leader>ccm", function() start_claude("minimax") end, desc = "Claude MiniMax" },
    { "<leader>cay", function() start_claude("anthropic_yolo") end, desc = "Claude Anthropic YOLO" },
    { "<leader>cmy", function() start_claude("minimax_yolo") end, desc = "Claude MiniMax YOLO" },
  },
  config = function()
    require("claude-code").setup({
      command = PROVIDER_SCRIPTS.anthropic,
      window = {
        position = "vertical botright", -- Open on the right instead of bottom
      },
    })
  end,
}
