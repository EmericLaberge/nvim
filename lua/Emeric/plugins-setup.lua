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

-- autocommand that reloads neovim and installs/updates/removes plugins that can
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
  use 'Mofiqul/dracula.nvim'


  -- Window management
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
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- Todo Comment
  --
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",

    config = function()
      require("todo-comments").setup {}
    end
  }

  -- instant nvim
  -- use "jbyuki/instant.nvim"

  -- gitdiff
  use "sindrets/diffview.nvim"
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup()
  end }
  -- git sign
  use "lewis6991/gitsigns.nvim"
  -- File explorer
  -- use("nvim-tree/nvim-tree.lua")
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    end
  }
  use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }

  -- Statusline
  use("nvim-lualine/lualine.nvim")

  -- Fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  use("neovim/nvim-lspconfig")
  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lua',
      'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
      'f3fora/cmp-spell', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-latex-symbols'
    }
    -- requires = {
    --   "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
    --   'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
    --   'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
    --   'f3fora/cmp-spell', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-latex-symbols'
    -- }
    -- requires = {
    --   "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
    --   "kdheepak/cmp-latex-symbols",
    --   "hrsh7th/cmp-nvim-lua",
    --   "octaltree/cmp-look", "hrsh7th/cmp-path", "hrsh7th/cmp-calc",
    --   "f3fora/cmp-spell", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-emoji"
    -- }
  })

  use({
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  })

  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  })



  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LSP, linting, and formatting
  use("williamboman/mason.nvim")
  use("jay-babu/mason-nvim-dap.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("folke/neodev.nvim")
  use("glepnir/lspsaga.nvim")
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")


  -- DAP plugins
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

  use { "mfussenegger/nvim-dap-python", requires = { "mfussenegger/nvim-dap" } }
  use("theHamsta/nvim-dap-virtual-text")

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
  --


  -- nvim-dap
  -- use 'mfussenegger/nvim-dap'
  -- use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  -- use 'theHamsta/nvim-dap-virtual-text'

  -- Miscellaneous plugins
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("laytan/cloak.nvim")
  use("windwp/nvim-autopairs")
  --
  -- -- Haskell plugins
  -- use 'neovimhaskell/haskell-vim'
  -- use 'ndmitchell/ghcid' -- If you want to use ghcid for automatic builds
  -- use({
  --   'mrcjkb/haskell-tools.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   version = '^2', -- Recommended
  --   ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  -- })

  -- use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
  use 'yamatsum/nvim-cursorline'

  -- indent line
  use({
    'lukas-reineke/indent-blankline.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  })
  use('xuhdev/vim-latex-live-preview')
  -- use 'alec-gibson/nvim-tetris'
  use 'kdheepak/lazygit.nvim'
  use("folke/noice.nvim")
  -- use 'eandrju/cellular-automaton.nvim'

  -- JUPYTER NOTEBOOK
  -- use('luk400/vim-jukit')
  use({
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  })
  use 'andweeb/presence.nvim'

  -- use 'ThePrimeagen/vim-be-good'
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

  -- j
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- lsp lines for rendering diagnostics
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  use {
    "nvim-neorg/neorg",
    rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim" },
    tag = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup()
    end,
  }
  use({
    "crnvl96/lazydocker.nvim",
    config = function()
      require("lazydocker").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    }
  })

  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  })

  use('TabbyML/vim-tabby');
  use({
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
  })


  -- use('github/copilot.vim')
  -- gen.nvim
  use({
    'David-Kunz/gen.nvim',
    config = function()
      require('gen').setup({
        model = 'llama3.1',  -- The model you want to use.
        show_prompt = false, -- Shows the prompt submitted to Ollama.
        show_model = false,  -- Displays which model you are using at the beginning of your chat session.
      })
    end
  })

  -- Tmux
  use({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
  })

  use('folke/tokyonight.nvim')

  use {
    'HakonHarnes/img-clip.nvim',
    config = function()
      require('img-clip').setup({
        -- add options here
        -- or leave it empty to use the default settings
      })
      -- set keymap
      vim.keymap.set('n', '<leader>p', '<cmd>PasteImage<cr>', { desc = 'Paste image from system clipboard' })
    end,
  }
  use "tris203/precognition.nvim"
  use { 'stevearc/dressing.nvim' }

  use "hiphish/rainbow-delimiters.nvim"
  use "stevearc/conform.nvim"

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",     -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })
  if packer_bootstrap then
    require("packer").sync()
  end
end)
