return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      -- Default configuration
      render = "background", -- 'background' | 'foreground' | 'icon' | 'text'
      enable_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_named_colors = true,
      priority = 1000,
    })
  end,
}
