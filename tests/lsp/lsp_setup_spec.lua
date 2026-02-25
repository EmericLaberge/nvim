describe("lsp_setup module", function()
  local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")

  it("loads without error", function()
    assert.is_true(ok, "lsp_setup failed to load: " .. tostring(lsp_setup))
  end)

  if not ok then return end

  describe("servers", function()
    it("exports a servers table", function()
      assert.is_table(lsp_setup.servers)
    end)

    it("has at least 10 servers", function()
      assert.is_true(#lsp_setup.servers >= 10,
        "expected >= 10 servers, got " .. #lsp_setup.servers)
    end)

    local expected_servers = {
      "pyright", "lua_ls", "rust_analyzer", "ts_ls", "gopls",
      "clangd", "bashls", "html", "cssls", "jsonls",
      "dockerls", "yamlls", "texlab", "sqls", "marksman",
    }

    for _, srv in ipairs(expected_servers) do
      it("includes " .. srv, function()
        assert.is_truthy(
          vim.tbl_contains(lsp_setup.servers, srv),
          srv .. " not found in servers list"
        )
      end)
    end
  end)

  describe("on_attach", function()
    it("exports on_attach as a function", function()
      assert.is_function(lsp_setup.on_attach)
    end)
  end)

  describe("lsp_flags", function()
    it("exports lsp_flags as a table", function()
      assert.is_table(lsp_setup.lsp_flags)
    end)

    it("sets debounce_text_changes to 150", function()
      assert.are.equal(150, lsp_setup.lsp_flags.debounce_text_changes)
    end)
  end)
end)
