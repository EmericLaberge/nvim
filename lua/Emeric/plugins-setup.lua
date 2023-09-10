-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- Lua utility libraries
  use("nvim-lua/plenary.nvim")

  -- Notifications and prompts for neovim
  use("rcarriga/nvim-notify")
  use("VonHeikemen/lsp-zero.nvim")
  use("MunifTanjim/nui.nvim")
  use("hrsh7th/cmp-nvim-lua")

  -- Colorschemes
  use("bluz71/vim-nightfly-guicolors")
  use 'Mofiqul/dracula.nvim'

  -- Tmux and split window navigation
  use("christoomey/vim-tmux-navigator")

  -- Window management
  use("szw/vim-maximizer")
  use("Bekaboo/deadcolumn.nvim")

  -- Essential plugins
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  use("inkarkat/vim-ReplaceWithRegister")

  -- Commenting
  use("numToStr/Comment.nvim")

  -- File explorer
  -- use("nvim-tree/nvim-tree.lua")
  use 'nvim-tree/nvim-web-devicons'
  use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }

  -- Statusline
  use("nvim-lualine/lualine.nvim")

  -- Fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "kdheepak/cmp-latex-symbols" },
    },
  })

  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LSP, linting, and formatting
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use("glepnir/lspsaga.nvim")
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-context")
  use("lervag/vimtex")

  -- Miscellaneous plugins
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  use("laytan/cloak.nvim")
  use("windwp/nvim-autopairs")
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
  use 'yamatsum/nvim-cursorline'
  use('xuhdev/vim-latex-live-preview')
  use("lukas-reineke/indent-blankline.nvim")
  use 'alec-gibson/nvim-tetris'
  use 'kdheepak/lazygit.nvim'
  use("folke/noice.nvim")
  use 'eandrju/cellular-automaton.nvim'
  use({
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  })
  use 'andweeb/presence.nvim'
  use 'glepnir/dashboard-nvim'
  use 'ThePrimeagen/vim-be-good'
  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("nvim-web-devicons").setup()

      require("nvim-tree").setup {
        hijack_cursor = true,
        view = {
          width = 40
        }
      }
    end
  }
  -- neorg for note taking
  use {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }
  -- Tmux
  use({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
  })


  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use 'theHamsta/nvim-dap-virtual-text'


  if packer_bootstrap then
    require("packer").sync()
  end
end)
