describe("core options", function()
  -- Helper to get option value
  local function opt(name)
    return vim.opt[name]:get()
  end

  describe("line numbers", function()
    it("enables relative numbers", function()
      assert.is_true(opt("relativenumber"))
    end)

    it("enables absolute number on cursor line", function()
      assert.is_true(opt("number"))
    end)
  end)

  describe("tabs & indentation", function()
    it("sets tabstop to 2", function()
      assert.are.equal(2, opt("tabstop"))
    end)

    it("sets shiftwidth to 2", function()
      assert.are.equal(2, opt("shiftwidth"))
    end)

    it("expands tabs to spaces", function()
      assert.is_true(opt("expandtab"))
    end)

    it("enables autoindent", function()
      assert.is_true(opt("autoindent"))
    end)
  end)

  describe("line wrapping", function()
    it("enables wrap", function()
      assert.is_true(opt("wrap"))
    end)

    it("enables linebreak", function()
      assert.is_true(opt("linebreak"))
    end)

    it("sets textwidth to 80", function()
      assert.are.equal(80, opt("textwidth"))
    end)
  end)

  describe("search", function()
    it("ignores case", function()
      assert.is_true(opt("ignorecase"))
    end)

    it("enables smartcase", function()
      assert.is_true(opt("smartcase"))
    end)
  end)

  describe("appearance", function()
    it("enables cursorline", function()
      assert.is_true(opt("cursorline"))
    end)

    it("sets colorcolumn to 80", function()
      local cc = opt("colorcolumn")
      assert.is_truthy(vim.tbl_contains(cc, "80"))
    end)

    it("enables termguicolors", function()
      assert.is_true(opt("termguicolors"))
    end)

    it("sets background to dark", function()
      assert.are.equal("dark", opt("background"))
    end)

    it("sets signcolumn to yes", function()
      assert.are.equal("yes", opt("signcolumn"))
    end)
  end)

  describe("clipboard", function()
    it("uses unnamedplus", function()
      local cb = opt("clipboard")
      -- vim.opt:get() returns a table for string-list options
      if type(cb) == "table" then
        assert.is_truthy(vim.tbl_contains(cb, "unnamedplus"))
      else
        assert.are.equal("unnamedplus", cb)
      end
    end)
  end)

  describe("splits", function()
    it("splits right", function()
      assert.is_true(opt("splitright"))
    end)

    it("splits below", function()
      assert.is_true(opt("splitbelow"))
    end)
  end)

  describe("iskeyword", function()
    it("includes hyphen", function()
      local kw = opt("iskeyword")
      assert.is_truthy(vim.tbl_contains(kw, "-"))
    end)
  end)
end)
