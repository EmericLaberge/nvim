describe("neotest", function()
  it("neotest plugin spec loads", function()
    local ok, spec = pcall(require, "Emeric.plugins.neotest")
    assert.is_true(ok, "neotest spec failed: " .. tostring(spec))
    assert.are.equal("nvim-neotest/neotest", spec[1] or spec.name or spec)
  end)

  it("neotest-python is a dependency", function()
    local spec = require("Emeric.plugins.neotest")
    local deps = spec.dependencies or {}
    local found = false
    for _, dep in ipairs(deps) do
      if type(dep) == "string" and dep == "nvim-neotest/neotest-python" then
        found = true
        break
      end
    end
    assert.is_true(found, "neotest-python not found in dependencies")
  end)

  it("neotest-busted is a dependency", function()
    local spec = require("Emeric.plugins.neotest")
    local deps = spec.dependencies or {}
    local found = false
    for _, dep in ipairs(deps) do
      if type(dep) == "string" and dep == "MisanthropicBit/neotest-busted" then
        found = true
        break
      end
    end
    assert.is_true(found, "neotest-busted not found in dependencies")
  end)
end)
