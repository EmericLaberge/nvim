describe("conform formatters", function()
  local ok, conform = pcall(require, "conform")

  -- Expected formatter-by-ft mappings from conform.lua
  local expected = {
    lua             = { "stylua" },
    python          = { "isort", "black" },
    javascript      = { "prettier" },
    typescript      = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css             = { "prettier" },
    html            = { "prettier" },
    json            = { "prettier" },
    yaml            = { "prettier" },
    markdown        = { "prettier" },
    graphql         = { "prettier" },
    perl            = { "perltidy" },
    sql             = { "sqlfluff" },
    tex             = { "latexindent" },
    latex           = { "latexindent" },
  }

  it("conform is loadable", function()
    assert.is_true(ok, "conform failed to load: " .. tostring(conform))
  end)

  if not ok then return end

  for ft, formatters in pairs(expected) do
    it("assigns correct formatters for " .. ft, function()
      local configured = conform.formatters_by_ft[ft]
      assert.is_truthy(configured, "no formatters configured for " .. ft)
      assert.are.same(formatters, configured)
    end)
  end
end)
