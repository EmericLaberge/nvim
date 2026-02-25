describe("leader keys", function()
  it("sets mapleader to space", function()
    assert.are.equal(" ", vim.g.mapleader)
  end)

  it("sets maplocalleader to backslash", function()
    assert.are.equal("\\", vim.g.maplocalleader)
  end)
end)
