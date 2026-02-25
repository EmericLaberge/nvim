describe("plugin modules", function()
  -- Every require() in plugins/init.lua should succeed without error.
  -- This catches syntax errors, missing dependencies, and broken requires.
  local plugin_modules = {
    "Emeric.plugins.tokyo",
    "Emeric.plugins.colors",
    "Emeric.plugins.telescope",
    "Emeric.plugins.lualine",
    "Emeric.plugins.treesitter",
    "Emeric.plugins.autopairs",
    "Emeric.plugins.comment",
    "Emeric.plugins.gitsigns",
    "Emeric.plugins.indent_blankline",
    "Emeric.plugins.nvim-tree",
    "Emeric.plugins.which-key",
    "Emeric.plugins.trouble",
    "Emeric.plugins.undotree",
    "Emeric.plugins.fugitive",
    "Emeric.plugins.hop",
    "Emeric.plugins.barbar",
    "Emeric.plugins.notify",
    "Emeric.plugins.zenmode",
    "Emeric.plugins.dashboard-nvim",
    "Emeric.plugins.nvim-cursorline",
    "Emeric.plugins.rainbow-delimiters",
    "Emeric.plugins.surround",
    "Emeric.plugins.replace-with-register",
    "Emeric.plugins.todo-comments",
    "Emeric.plugins.diffview",
    "Emeric.plugins.git-conflict",
    "Emeric.plugins.nvim-web-devicons",
    "Emeric.plugins.telescope-fzf-native",
    "Emeric.plugins.luasnip",
    "Emeric.plugins.cmp-luasnip",
    "Emeric.plugins.friendly-snippets",
    "Emeric.plugins.lazydev",
    "Emeric.plugins.lspsaga",
    "Emeric.plugins.hover",
    "Emeric.plugins.lazygit",
    "Emeric.plugins.obsidian",
    "Emeric.plugins.tmux",
    "Emeric.plugins.img-clip",
    "Emeric.plugins.csvview",
    "Emeric.plugins.precognition",
    "Emeric.plugins.dressing",
    "Emeric.plugins.render-markdown",
    "Emeric.plugins.multicursor",
    "Emeric.plugins.dropbar",
    "Emeric.plugins.colorizer",
    "Emeric.plugins.mason",
    "Emeric.plugins.lsp",
    "Emeric.plugins.nvim-cmp",
    "Emeric.plugins.lspkind",
    "Emeric.plugins.conform",
    "Emeric.plugins.lint",
    "Emeric.plugins.lsp_lines",
    "Emeric.plugins.copilot",
    "Emeric.plugins.claude-code",
    "Emeric.plugins.neotest",
    "Emeric.plugins.cloak",
    "Emeric.plugins.presence",
    "Emeric.plugins.lazydocker",
    "Emeric.plugins.refactoring",
    "Emeric.plugins.vimtex",
    "Emeric.plugins.noice",
  }

  for _, mod in ipairs(plugin_modules) do
    it("can require " .. mod, function()
      local ok, err = pcall(require, mod)
      assert.is_true(ok, "Failed to require " .. mod .. ": " .. tostring(err))
    end)
  end

  it("plugins/init.lua returns a table", function()
    local specs = require("Emeric.plugins")
    assert.is_table(specs)
    assert.is_true(#specs > 0, "plugin spec table is empty")
  end)
end)
