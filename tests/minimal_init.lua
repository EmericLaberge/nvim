-- Minimal Neovim init for running busted tests
-- Usage: nvim --headless -u tests/minimal_init.lua ...

-- Leaders must be set before any plugin loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim (assumes it's already installed)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- Load plugins via lazy.nvim (same spec as real config)
require("lazy").setup("Emeric.plugins", {
  defaults = { lazy = true },
  install = { missing = false }, -- don't install anything during tests
  change_detection = { enabled = false },
  checker = { enabled = false },
})

-- Load core modules (same order as real init.lua)
require("Emeric.core.options")
require("Emeric.core.keymaps")
-- Skip colorscheme — it can fail without a real terminal
pcall(require, "Emeric.core.colorscheme")
