-- Helper: check if a keymap with the given lhs exists in the given mode.
-- Normalizes key notation so e.g. "<C-c>" matches "<C-C>".
local function has_keymap(mode, lhs)
  local normalized = vim.api.nvim_replace_termcodes(lhs, true, true, true)
  local maps = vim.api.nvim_get_keymap(mode)
  for _, m in ipairs(maps) do
    local m_norm = vim.api.nvim_replace_termcodes(m.lhs, true, true, true)
    if m_norm == normalized then
      return true
    end
  end
  return false
end

describe("core keymaps", function()
  describe("insert mode escapes", function()
    it("maps jj", function()
      assert.is_true(has_keymap("i", "jj"))
    end)

    it("maps jk", function()
      assert.is_true(has_keymap("i", "jk"))
    end)

    it("maps <C-c>", function()
      assert.is_true(has_keymap("i", "<C-c>"))
    end)

    it("maps <C-S> to save", function()
      assert.is_true(has_keymap("i", "<C-S>"))
    end)
  end)

  describe("normal mode - general", function()
    it("maps <leader>nh to clear highlights", function()
      assert.is_true(has_keymap("n", " nh"))
    end)

    it("maps x to delete without register", function()
      assert.is_true(has_keymap("n", "x"))
    end)

    it("maps Q to nop", function()
      assert.is_true(has_keymap("n", "Q"))
    end)
  end)

  describe("normal mode - window management", function()
    local splits = { " sv", " sh", " se", " sx" }
    for _, lhs in ipairs(splits) do
      it("maps " .. lhs, function()
        assert.is_true(has_keymap("n", lhs))
      end)
    end
  end)

  describe("normal mode - telescope", function()
    local telescope_maps = { " ff", " fg", " fc", " fb", " fh" }
    for _, lhs in ipairs(telescope_maps) do
      it("maps " .. lhs, function()
        assert.is_true(has_keymap("n", lhs))
      end)
    end
  end)

  describe("normal mode - tabs", function()
    local tab_maps = { " to", " tx", " tn", " tp" }
    for _, lhs in ipairs(tab_maps) do
      it("maps " .. lhs, function()
        assert.is_true(has_keymap("n", lhs))
      end)
    end
  end)

  describe("visual mode", function()
    it("maps J to move line down", function()
      assert.is_true(has_keymap("v", "J"))
    end)

    it("maps K to move line up", function()
      assert.is_true(has_keymap("v", "K"))
    end)
  end)

  describe("visual mode - yank/delete", function()
    it("maps <leader>y to clipboard yank", function()
      assert.is_true(has_keymap("v", " y"))
    end)

    it("maps <leader>d to delete without register", function()
      assert.is_true(has_keymap("v", " d"))
    end)
  end)

  describe("visual mode - paste", function()
    it("maps <leader>p to paste without yanking", function()
      assert.is_true(has_keymap("x", " p"))
    end)
  end)

  describe("window navigation", function()
    local nav = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" }
    for _, lhs in ipairs(nav) do
      it("maps " .. lhs, function()
        assert.is_true(has_keymap("n", lhs))
      end)
    end
  end)

  describe("quickfix navigation", function()
    it("maps ]q to next quickfix", function()
      assert.is_true(has_keymap("n", "]q"))
    end)

    it("maps [q to previous quickfix", function()
      assert.is_true(has_keymap("n", "[q"))
    end)
  end)

  describe("plugin triggers", function()
    it("maps <leader>gg for lazygit", function()
      assert.is_true(has_keymap("n", " gg"))
    end)
  end)

  describe("LaTeX / VimTeX", function()
    local vimtex_maps = { "\\ll", "\\lv", "\\le", "\\lk", "\\li", "\\ls", "\\lt", "\\lc" }
    for _, lhs in ipairs(vimtex_maps) do
      it("maps " .. lhs, function()
        assert.is_true(has_keymap("n", lhs))
      end)
    end
  end)
end)
