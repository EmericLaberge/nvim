describe("nvim-lint linters", function()
  local ok, lint = pcall(require, "lint")

  local expected = {
    javascript      = { "eslint_d" },
    typescript      = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python          = { "pylint", "ruff" },
    lua             = { "luacheck" },
    sh              = { "shellcheck" },
    bash            = { "shellcheck" },
    zsh             = { "shellcheck" },
    yaml            = { "yamllint" },
    json            = { "jsonlint" },
    markdown        = { "markdownlint" },
    dockerfile      = { "hadolint" },
    sql             = { "sqlfluff" },
  }

  it("nvim-lint is loadable", function()
    assert.is_true(ok, "lint failed to load: " .. tostring(lint))
  end)

  if not ok then return end

  for ft, linters in pairs(expected) do
    it("assigns correct linters for " .. ft, function()
      local configured = lint.linters_by_ft[ft]
      assert.is_truthy(configured, "no linters configured for " .. ft)
      assert.are.same(linters, configured)
    end)
  end
end)
