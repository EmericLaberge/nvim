describe("mason / lsp_setup server consistency", function()
  local ok_lsp, lsp_setup = pcall(require, "Emeric.lsp_setup")

  it("lsp_setup loads", function()
    assert.is_true(ok_lsp, "lsp_setup failed to load: " .. tostring(lsp_setup))
  end)

  if not ok_lsp then return end

  -- The mason.lua fallback list — should stay in sync with lsp_setup.servers
  local mason_fallback = {
    "bashls", "clangd", "cssls", "dockerls", "gopls",
    "html", "jsonls", "lua_ls", "marksman", "omnisharp",
    "perlnavigator", "phpactor", "pyright", "rust_analyzer",
    "sqls", "texlab", "ts_ls", "yamlls",
  }

  it("every mason fallback server is in lsp_setup.servers", function()
    local missing = {}
    for _, srv in ipairs(mason_fallback) do
      if not vim.tbl_contains(lsp_setup.servers, srv) then
        table.insert(missing, srv)
      end
    end
    assert.are.same({}, missing,
      "servers in mason fallback but not lsp_setup: " .. table.concat(missing, ", "))
  end)

  it("lsp_setup.servers is a superset of the mason fallback", function()
    -- lsp_setup may have extra servers (e.g. jdtls, csharp_ls) that aren't
    -- in the mason fallback — that's fine. But every mason fallback entry
    -- must exist in lsp_setup so they don't drift apart silently.
    for _, srv in ipairs(mason_fallback) do
      assert.is_truthy(
        vim.tbl_contains(lsp_setup.servers, srv),
        srv .. " missing from lsp_setup.servers"
      )
    end
  end)

  it("lsp_setup.servers has no duplicates", function()
    local seen = {}
    local dupes = {}
    for _, srv in ipairs(lsp_setup.servers) do
      if seen[srv] then
        table.insert(dupes, srv)
      end
      seen[srv] = true
    end
    assert.are.same({}, dupes,
      "duplicate servers in lsp_setup: " .. table.concat(dupes, ", "))
  end)
end)
