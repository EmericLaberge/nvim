-- Load .env file if present
local env_file = vim.fn.stdpath("config") .. "/.env"
local env = vim.fn.filereadable(env_file) == 1 and vim.fn.readfile(env_file) or {}
for _, line in ipairs(env) do
  local key, value = line:match("^([^=]+)=(.*)$")
  if key and value then
    vim.env[key] = value
  end
end

-- Set leader before plugins / lazy.nvim load so plugin setup can reference it
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("Emeric.plugins", {
	checker = {
		enabled = true,
	},
	change_detection = {
		notify = false,
	},
})

require("Emeric.core.options")
require("Emeric.core.keymaps")
require("Emeric.core.colorscheme")
