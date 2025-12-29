This file is a merged representation of a subset of the codebase, containing files not matching ignore patterns, combined into a single document by Repomix.

# File Summary

## Purpose
This file contains a packed representation of a subset of the repository's contents that is considered the most important context.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching these patterns are excluded: assets/**, pack/**, lazy-lock.json, **/package-lock.json, **/*.log, **/*.png, **/*.txt, **/.git/**
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Files are sorted by Git change count (files with more changes are at the bottom)

# Directory Structure
```
lua/
  Emeric/
    core/
      colorscheme.lua
      keymaps.lua
      options.lua
    plugins/
      autopairs.lua
      avante.lua
      barbar.lua
      barbecue.lua
      cloak.lua
      cmp-dictionary.lua
      cmp-luasnip.lua
      colorizer.lua
      colors.lua
      comment.lua
      conform.lua
      copilot-chat.lua
      copilot-cmp.lua
      copilot.lua
      csvview.lua
      cursorline.lua
      dap.lua
      dapui.lua
      dashboard-nvim.lua
      diffview.lua
      dracula.lua
      dressing.lua
      friendly-snippets.lua
      fugitive.lua
      gen_nvim.lua
      git-conflict.lua
      gitsigns.lua
      harpoon.lua
      hop.lua
      hover.lua
      img-clip.lua
      indent_blankline.lua
      init.lua
      jdtls.lua
      lazydocker.lua
      lazygit.lua
      log.py
      lsp_lines.lua
      lsp.lua
      lspkind.lua
      lspsaga.lua
      lualine.lua
      luasnip.lua
      mason-null-ls.lua
      mason-nvim-dap.lua
      mason.lua
      multicursor.lua
      neodev.lua
      neorg.lua
      noice.lua
      notify.lua
      null-ls.lua
      nvim-cmp.lua
      nvim-cursorline.lua
      nvim-dap-python.lua
      nvim-dap-virtual-text.lua
      nvim-tree.lua
      nvim-web-devicons.lua
      obsidian.lua
      opencode.lua
      precognition.lua
      presence.lua
      rainbow-delimiters.lua
      refactoring.lua
      render-markdown.lua
      replace-with-register.lua
      surround.lua
      tabby.lua
      telescope-fzf-native.lua
      telescope.lua
      tmux.lua
      todo-comments.lua
      tokyo.lua
      treesitter-context.lua
      treesitter-playground.lua
      treesitter.lua
      trouble.lua
      undotree.lua
      vim-tabby.lua
      vimtex.lua
      which-key.lua
      zenmode.lua
    lsp_setup.lua
image.py
init.lua
repomix.config.json
rocks.toml
```

# Files

## File: lua/Emeric/plugins/csvview.lua
```lua
return {
  "hat0uma/csvview.nvim",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  config = function()
    require("csvview").setup({
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    })
  end,
}
```

## File: lua/Emeric/plugins/log.py
```python
import os

def log_all_files(directory, log_file_path):
    with open(log_file_path, 'w') as log_file:
        for file_name in sorted(os.listdir(directory)):
            file_path = os.path.join(directory, file_name)
            if os.path.isfile(file_path):
                log_file.write(f"\n--- {file_name} ---\n")
                with open(file_path, 'r') as current_file:
                    log_file.write(current_file.read())
                    log_file.write("\n")

# Example usage:
log_all_files('.', 'log.txt')
```

## File: lua/Emeric/plugins/opencode.lua
```lua
return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "opencode: Ask" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "opencode: Select action" })
    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "opencode: Toggle" })
  end,
}
```

## File: image.py
```python
from PIL import Image

# Define the size of the image
width, height = 2560, 1664

# Create a new black image
image = Image.new('RGB', (width, height), color='black')

# Set the coordinates of the white pixel
white_pixel_coordinates = (width // 2, height // 2)

# Set the white pixel
image.putpixel(white_pixel_coordinates, (255, 255, 255))

# Save the image
image.save('one_white_pixel_2560x1664.png')

# Show the image
image.show()
```

## File: repomix.config.json
```json
{
  "output": {
    "style": "markdown",
    "filePath": "repomix-output.md"
  },
  "ignore": {
    "customPatterns": [
      "assets/**",
      "pack/**",
      "lazy-lock.json",
      "**/package-lock.json",
      "**/*.log",
      "**/*.png",
      "**/*.txt",
      "**/.git/**"
    ]
  }
}
```

## File: lua/Emeric/plugins/dressing.lua
```lua
return {
  'stevearc/dressing.nvim',
}
```

## File: lua/Emeric/plugins/hover.lua
```lua
return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				-- require('hover.providers.dap')
				-- require('hover.providers.man')
				-- require('hover.providers.dictionary')
			end,
			preview_opts = {
				border = "rounded",
			},
			-- Whether the contents of a single provider can be previewed
			-- together in a single floating window.
			preview_multiple = true,
			-- Whether floating windows are automatically focusable
			focusable = false,
			title = false,
		})
	end,
}
```

## File: rocks.toml
```toml
# This is your rocks.nvim plugins declaration file.
# Here is a small yet pretty detailed example on how to use it:
#
# [plugins]
# nvim-treesitter = "semver_version"  # e.g. "1.0.0"

# List of non-Neovim rocks.
# This includes things like `toml` or other lua packages.
[rocks]

# List of Neovim plugins to install alongside their versions.
# If the plugin name contains a dot then you must add quotes to the key name!
[plugins]
"rocks.nvim" = "2.42.4" # rocks.nvim can also manage itself :D
neorg = "9.1.1"
rustaceanvim = "5.24.0"
"rocks-config.nvim" = "3.1.0"
```

## File: lua/Emeric/plugins/barbecue.lua
```lua
return {
  "utilyre/barbecue.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  after = "nvim-web-devicons",     -- keep this if you're using NvChad
  config = function()
    require("barbecue").setup()
  end,
}
```

## File: lua/Emeric/plugins/cmp-dictionary.lua
```lua
return {
  "uga-rosa/cmp-dictionary",
  dependencies = { "hrsh7th/nvim-cmp" },
}
```

## File: lua/Emeric/plugins/cmp-luasnip.lua
```lua
return {
  "saadparwaiz1/cmp_luasnip",
}
```

## File: lua/Emeric/plugins/colorizer.lua
```lua
return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}
```

## File: lua/Emeric/plugins/cursorline.lua
```lua
return {
  "yamatsum/nvim-cursorline",
}
```

## File: lua/Emeric/plugins/diffview.lua
```lua
return {
  "sindrets/diffview.nvim",
}
```

## File: lua/Emeric/plugins/dracula.lua
```lua
return {
  "Mofiqul/dracula.nvim",
}
```

## File: lua/Emeric/plugins/friendly-snippets.lua
```lua
return {
  "rafamadriz/friendly-snippets",
}
```

## File: lua/Emeric/plugins/git-conflict.lua
```lua
return {
  'akinsho/git-conflict.nvim',
  config = function()
    require('git-conflict').setup()
  end,
}
```

## File: lua/Emeric/plugins/img-clip.lua
```lua
return {
  'HakonHarnes/img-clip.nvim',
  config = function()
    require('img-clip').setup({
    })
    vim.keymap.set('n', '<leader>p', '<cmd>PasteImage<cr>', { desc = 'Paste image from system clipboard' })
  end,
}
```

## File: lua/Emeric/plugins/lazygit.lua
```lua
return {
  'kdheepak/lazygit.nvim',
}
```

## File: lua/Emeric/plugins/luasnip.lua
```lua
return {
  "L3MON4D3/LuaSnip",
}
```

## File: lua/Emeric/plugins/mason-null-ls.lua
```lua
return {
  "jayp0521/mason-null-ls.nvim",
}
```

## File: lua/Emeric/plugins/multicursor.lua
```lua
return {
  "jake-stewart/multicursor.nvim",
}
```

## File: lua/Emeric/plugins/neodev.lua
```lua
return {
  "folke/neodev.nvim",
}
```

## File: lua/Emeric/plugins/null-ls.lua
```lua
return {
  "jose-elias-alvarez/null-ls.nvim",
}
```

## File: lua/Emeric/plugins/nvim-dap-python.lua
```lua
return {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap" },
}
```

## File: lua/Emeric/plugins/nvim-dap-virtual-text.lua
```lua
return {
  "theHamsta/nvim-dap-virtual-text",
}
```

## File: lua/Emeric/plugins/nvim-web-devicons.lua
```lua
return {
  'kyazdani42/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  end,
}
```

## File: lua/Emeric/plugins/obsidian.lua
```lua
return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
```

## File: lua/Emeric/plugins/precognition.lua
```lua
return {
  "tris203/precognition.nvim",
}
```

## File: lua/Emeric/plugins/render-markdown.lua
```lua
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'echasnovski/mini.nvim', opt = true },
  config = function()
    require('render-markdown').setup({})
  end,
}
```

## File: lua/Emeric/plugins/replace-with-register.lua
```lua
return {
  "inkarkat/vim-ReplaceWithRegister",
}
```

## File: lua/Emeric/plugins/surround.lua
```lua
return {
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
```

## File: lua/Emeric/plugins/telescope-fzf-native.lua
```lua
return {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
}
```

## File: lua/Emeric/plugins/tmux.lua
```lua
return {
  "aserowy/tmux.nvim",
  config = function() return require("tmux").setup() end,
}
```

## File: lua/Emeric/plugins/todo-comments.lua
```lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup {}
  end,
}
```

## File: lua/Emeric/plugins/treesitter-context.lua
```lua
return {
  "nvim-treesitter/nvim-treesitter-context",
}
```

## File: lua/Emeric/plugins/vim-tabby.lua
```lua
return {
  'TabbyML/vim-tabby',
}
```

## File: lua/Emeric/plugins/avante.lua
```lua
return {
  "yetone/avante.nvim",
  build = "make BUILD_FROM_SOURCE=true",
  lazy = false,
  version = false,
  BUILD_FROM_SOURCE = true,
  config = function()
    require("avante_lib").load()
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "HakonHarnes/img-clip.nvim",
  },
}
```

## File: lua/Emeric/plugins/comment.lua
```lua
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
}
```

## File: lua/Emeric/plugins/copilot-chat.lua
```lua
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  build = "make tiktoken", -- Build step for tiktoken (MacOS/Linux)
  config = function()
    local ok, cc = pcall(require, "CopilotChat")
    if ok and cc and cc.setup then
      cc.setup({})
    end
  end,
}
```

## File: lua/Emeric/plugins/copilot-cmp.lua
```lua
return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", "nvim-cmp" },
  config = function()
    -- copilot-cmp registers a source named 'copilot' for nvim-cmp. Configure
    -- it with reasonable defaults so it plays nicely with other sources.
    require("copilot_cmp").setup({
      method = "getCompletionsCycling",
      -- Optionally debounce to reduce churn
      debounce = 75,
    })
  end,
}
```

## File: lua/Emeric/plugins/gitsigns.lua
```lua
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
}
```

## File: lua/Emeric/plugins/lazydocker.lua
```lua
return {
  "crnvl96/lazydocker.nvim",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>ld', ':LazyDocker<CR>', { noremap = true, silent = true })
  end,
}
```

## File: lua/Emeric/plugins/lsp_lines.lua
```lua
return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
}
```

## File: lua/Emeric/plugins/lspsaga.lua
```lua
return {
  "glepnir/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
				code_action = "",
			},
			hover = {
				enabled = false,
			},
		})
	end,
}
```

## File: lua/Emeric/plugins/presence.lua
```lua
return {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
        auto_update         = true,
        neovim_image_text   = "The One True Text Editor",
        main_image          = "neovim",
        client_id           = "793271441293967371",
        log_level           = nil,
        debounce_timeout    = 10,
        enable_line_number  = false,
        blacklist           = {},
        buttons             = true,
        file_assets         = {},
        show_time           = true,
        editing_text        = "Editing %s",
        file_explorer_text  = "Browsing %s",
        git_commit_text     = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text        = "Reading %s",
        workspace_text      = "Working on %s",
        line_number_text    = "Line %s out of %s",
    })
  end,
}
```

## File: lua/Emeric/plugins/rainbow-delimiters.lua
```lua
return {
  "hiphish/rainbow-delimiters.nvim",
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    }
  end,
}
```

## File: lua/Emeric/plugins/refactoring.lua
```lua
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('refactoring').setup({})
    vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
  end,
}
```

## File: lua/Emeric/plugins/treesitter-playground.lua
```lua
return {
  "nvim-treesitter/playground",
  enabled = false,
}
```

## File: lua/Emeric/plugins/trouble.lua
```lua
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
      {silent = true, noremap = true}
    )
  end,
}
```

## File: lua/Emeric/plugins/autopairs.lua
```lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
```

## File: lua/Emeric/plugins/cloak.lua
```lua
return {
  "laytan/cloak.nvim",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = {
              ".env*",
              "wrangler.toml",
              ".dev.vars",
          },
          cloak_pattern = "=.+"
        },
      },
    })
  end,
}
```

## File: lua/Emeric/plugins/conform.lua
```lua
return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        perl = { 'perltidy' },
        python = { 'black' },
        sql = { 'sqlfluff' },
      },
      formatters = {
        sqlfluff = {
          command = 'sqlfluff',
          args = { 'format', '--dialect=postgres', '-' },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { noremap = true, desc = 'Format file or selection' })
  end,
}
```

## File: lua/Emeric/plugins/fugitive.lua
```lua
return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Fugitive" })

    local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
        group = ThePrimeagen_Fugitive,
        pattern = "*",
        callback = function()
            if vim.bo.ft ~= "fugitive" then
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "<leader>p", function()
                vim.cmd.Git('push')
            end, { buffer = bufnr, remap = false, desc = "Git Push (Fugitive)" })

            vim.keymap.set("n", "<leader>P", function()
                vim.cmd.Git({'pull',  '--rebase'})
            end, { buffer = bufnr, remap = false, desc = "Git Pull Rebase (Fugitive)" })

            vim.keymap.set("n", "<leader>t", ":Git push -u origin ", { buffer = bufnr, remap = false, desc = "Git Push Set Upstream (Fugitive)" });
        end,
    })
  end,
}
```

## File: lua/Emeric/plugins/harpoon.lua
```lua
return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon Add File" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon Toggle Menu" })

    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon Nav File 1" })
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Harpoon Nav File 2" })
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon Nav File 3" })
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon Nav File 4" })
  end,
}
```

## File: lua/Emeric/plugins/jdtls.lua
```lua
return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local opts = {
      cmd = {},
      settings = {
        java = {
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {},
            filteredTypes = {},
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = vim.fn.exepath("java") and vim.fn.fnamemodify(vim.fn.exepath("java"), ":h:h") or "/usr/lib/jvm/java-17-openjdk",
                default = true,
              },
            },
          },
        },
      },
    }

    local function setup()
      local jdtls = require("jdtls")
      local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
      local root_markers = { ".gradle", "gradlew", ".git" }
      local root_dir = jdtls.setup.find_root(root_markers)
      if not root_dir then return {} end
      local home = os.getenv("HOME")
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

      opts.cmd = {
        jdtls_bin,
        "-data",
        workspace_dir,
      }

      opts.on_attach = function(client, bufnr)
        jdtls.setup.add_commands()
      end
      opts.capabilities = vim.lsp.protocol.make_client_capabilities()

      return opts
    end

    local augroup = vim.api.nvim_create_augroup("jdtls", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "java",
      callback = function()
        local config = setup()
        if config.cmd and #config.cmd > 0 then
          vim.lsp.start({
            name = "jdtls",
            cmd = config.cmd,
            root_dir = config.root_dir,
            on_attach = config.on_attach,
            capabilities = config.capabilities,
            settings = opts.settings,
          })
        end
      end,
    })
  end,
}
```

## File: lua/Emeric/plugins/lspkind.lua
```lua
return {
  "onsails/lspkind.nvim",
  config = function()
    local lspkind = require("lspkind")
    -- Ne pas utiliser lspkind.init() car cela modifie CompletionItemKind globalement
    -- et cause une duplication d'icônes avec lspkind.cmp_format()
    -- À la place, on définit juste la couleur pour Copilot
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
  end,
}
```

## File: lua/Emeric/plugins/lualine.lua
```lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lualine_nightfly = require("lualine.themes.nightfly")

    local new_colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      black = "#000000",
    }

    lualine_nightfly.normal.a.bg = new_colors.blue
    lualine_nightfly.insert.a.bg = new_colors.green
    lualine_nightfly.visual.a.bg = new_colors.violet
    lualine_nightfly.command = {
      a = {
        gui = "bold",
        bg = new_colors.yellow,
        fg = new_colors.black,
      },
    }

    lualine.setup({
      options = {
        theme = 'tokyonight'
      },
    })
  end,
}
```

## File: lua/Emeric/plugins/mason-nvim-dap.lua
```lua
return {
  "williamboman/mason-nvim-dap.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require ('mason-nvim-dap').setup({
        ensure_installed = {'stylua', 'jq'},
        handlers = {
            function(config)
              require('mason-nvim-dap').default_setup(config)
            end,
            python = function(config)
                config.adapters = {
                  type = "executable",
                  command = "/usr/bin/python3",
                  args = {
                    "-m",
                    "debugpy.adapter",
                  },
                }
                require('mason-nvim-dap').default_setup(config)
            end,
        },
    })
  end,
}
```

## File: lua/Emeric/plugins/notify.lua
```lua
return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "#000000",
      top_down = false
    })
  end,
}
```

## File: lua/Emeric/plugins/nvim-cursorline.lua
```lua
return {
  "yamatsum/nvim-cursorline",
  config = function()
    local ok, cursorline = pcall(require, 'nvim-cursorline')
    if not ok then
      vim.notify("Failed to load nvim-cursorline", vim.log.levels.WARN)
      return
    end
    
    cursorline.setup {
      cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      }
    }
    
    -- Disable cursorline plugin functionality for binary files to prevent Blob errors
    -- This prevents the plugin from trying to process binary data
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo.binary then
          -- Disable cursorline for binary buffers
          vim.wo.cursorline = false
          -- Try to disable the plugin's autocmds for this buffer
          pcall(vim.api.nvim_clear_autocmds, { buffer = buf, group = "nvim-cursorline" })
        end
      end,
    })
  end,
}
```

## File: lua/Emeric/plugins/undotree.lua
```lua
return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
  end,
}
```

## File: lua/Emeric/plugins/barbar.lua
```lua
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local map = vim.api.nvim_set_keymap
    map('n', '<A-;>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Buffer Previous" })
    map('n', '<A-\'>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "Buffer Next" })
    map('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = "Buffer Move Previous" })
    map('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = "Buffer Move Next" })
    map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "Buffer Goto 1" })
    map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "Buffer Goto 2" })
    map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "Buffer Goto 3" })
    map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "Buffer Goto 4" })
    map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "Buffer Goto 5" })
    map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "Buffer Goto 6" })
    map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "Buffer Goto 7" })
    map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "Buffer Goto 8" })
    map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "Buffer Goto 9" })
    map('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = "Buffer Last" })
    map('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "Buffer Pin" })
    map('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Buffer Close" })
    map('n', '<C-p>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true, desc = "Buffer Pick" })
    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { noremap = true, silent = true, desc = "Buffer Order By Number" })
    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', { noremap = true, silent = true, desc = "Buffer Order By Directory" })
    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', { noremap = true, silent = true, desc = "Buffer Order By Language" })
    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { noremap = true, silent = true, desc = "Buffer Order By Window" })
  end,
}
```

## File: lua/Emeric/plugins/colors.lua
```lua
return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require('rose-pine').setup({
        disable_background = true
    })

    function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    ColorMyPencils()
  end,
}
```

## File: lua/Emeric/plugins/dapui.lua
```lua
return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local ok_dapui, dapui = pcall(require, "dapui")
    if not ok_dapui then
      vim.notify("dapui not available; ensure nvim-nio is installed and loaded before dap-ui", vim.log.levels.WARN)
      return
    end
    dapui.setup({
      floating = {
        border = 'rounded',
      },
    })
    vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = 'Dap UI' })
    vim.keymap.set({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, { desc = 'Eval' })
  end,
}
```

## File: lua/Emeric/plugins/dashboard-nvim.lua
```lua
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local db = require("dashboard")
    db.setup({
      theme = "hyper",
      config = {
        header = {
          'Hello, Emeric!'
        },
        center = {
          {
            icon = ' ',
            desc = 'Find File',
            key = 'f',
            action = 'Telescope find_files'
          },
          {
            icon = ' ',
            desc = 'Recently Used Files',
            key = 'r',
            action = 'Telescope oldfiles'
          },
          {
            icon = ' ',
            desc = 'Load Last Session',
            key = 's',
            action = 'SessionLoad'
          },
          {
            icon = ' ',
            desc = 'Find Word',
            key = 'g',
            action = 'Telescope live_grep'
          },
          {
            icon = ' ',
            desc = 'Marks',
            key = 'm',
            action = 'Telescope marks'
          }
        },
        footer = {'Neovim loaded for Emeric!'}
      }
    })
  end,
}
```

## File: lua/Emeric/plugins/neorg.lua
```lua
return {
  "nvim-neorg/neorg",
  enabled = false,
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = { notes = "~/notes" },
            default_workspace = "notes",
          }
        }
      }
    }
    vim.cmd [[
      hi NeorgHeading1 guifg=#FF5733 gui=bold
      hi NeorgHeading2 guifg=#33FF57 gui=bold
      hi NeorgHeading3 guifg=#3357FF gui=bold
      hi NeorgListBullet1 guifg=#F0F033 gui=bold
      hi NeorgListBullet2 guifg=#33F0F0 gui=bold
    ]]
  end,
}
```

## File: lua/Emeric/plugins/noice.lua
```lua
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      hover = {
        silent = true,
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },
      },
    })
  end,
}
```

## File: lua/Emeric/plugins/nvim-tree.lua
```lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()
  end,
}
```

## File: lua/Emeric/plugins/telescope.lua
```lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    })
    pcall(telescope.load_extension, "fzf")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Telescope Find Files" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Telescope Git Files" })
    vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Telescope Grep String" })
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Telescope Help Tags" })
  end,
}
```

## File: lua/Emeric/plugins/tokyo.lua
```lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
    })
  end,
}
```

## File: lua/Emeric/plugins/zenmode.lua
```lua
return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").setup {
        window = {
          width = 90,
          options = {}
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
    end, { desc = "Toggle Zen Mode (Normal)" })

    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").setup {
        window = {
          width = 80,
          options = {}
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      vim.opt.colorcolumn = "0"
    end, { desc = "Toggle Zen Mode (Minimal)" })
  end,
}
```

## File: lua/Emeric/lsp_setup.lua
```lua
local M = {}

-- Make hover popups non-focusable so the cursor stays in the editor when
-- pressing K (Shift+k). This prevents the floating window from taking
-- focus and moving the cursor into it.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	focusable = false,
})

M.servers = {
    "bashls",
    "clangd",
    "csharp_ls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "marksman",
    "omnisharp",
    "perlnavigator",
    "phpactor",
    "pyright",
    "rust_analyzer",
    "sqls",
    "texlab",
    "ts_ls",
    "yamlls",
}

M.lsp_flags = {
    debounce_text_changes = 150,
}

M.on_attach = function(client, bufnr)
    local builtin = require("telescope.builtin")
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr, desc = "Go To Definition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr, desc = "Go To References" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = bufnr, desc = "Go To Implementation" })
    vim.keymap.set("n", "<space>D", builtin.lsp_type_definitions, { buffer = bufnr, desc = "Go To Type Definition" })
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { buffer = bufnr, desc = "Workspace Symbols" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go To Declaration" })
    vim.keymap.set("n", "K", require("hover").hover, { buffer = bufnr, desc = "Hover Documentation" })
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = "Format Code" })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		-- Check if any LSP client supports document highlighting
		local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/documentHighlight") then
				vim.lsp.buf.document_highlight()
				break
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- Clear highlights when leaving the buffer
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

return M
```

## File: lua/Emeric/plugins/dap.lua
```lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    vim.keymap.set('n','<leader>dc', function() dap.continue() end, { desc = 'Continue' })
    vim.keymap.set('n','<leader>ds', function() dap.step_over() end, { desc = 'Step Over' })
    vim.keymap.set('n','<leader>di', function() dap.step_into() end, { desc = 'Step Into' })
    vim.keymap.set('n','<leader>do', function() dap.step_out() end, { desc = 'Step Out' })
    vim.keymap.set('n','<leader>dt', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n','<leader>dr', function() dap.repl.open() end, { desc = 'Open REPL' })
    vim.keymap.set('n','<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
    vim.keymap.set('n','<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n','<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Set Breakpoint' })
  end,
}
```

## File: lua/Emeric/plugins/gen_nvim.lua
```lua
return {
  "David-Kunz/gen.nvim",
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>', { desc = "Run Gen" })
    require('gen').setup {
        opts = {
            model = "llama3.1",
            host = "localhost",
            port = "11434",
            quit_map = "q",
            retry_map = "<c-r>",
            init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
            command = function(options)
                local body = {model = options.model, stream = true}
                return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
            end,
            display_mode = "split",
            show_prompt = false,
            show_model = false,
            no_auto_close = false,
            debug = false
        }
    }
  end,
}
```

## File: lua/Emeric/plugins/hop.lua
```lua
return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    local hop = require('hop')
    -- Ensure Hop is initialized before using its API
    hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

    local directions = require('hop.hint').HintDirection
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop Char1 After Cursor" })
    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop Char1 Before Cursor" })
  end,
}
```

## File: lua/Emeric/plugins/indent_blankline.lua
```lua
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    vim.g.indent_blankline_buftype_exclude = { "terminal" }
    require("ibl").setup { scope = { highlight = highlight } }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
```

## File: lua/Emeric/core/colorscheme.lua
```lua
local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg =true, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights see `:h synIDattr`
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
  },
})

-- require('tokyonight').setup({
--   style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--   transparent = true, -- Enable this to disable setting the background color
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--   styles = {
--     -- Style to be applied to different syntax groups
--     -- Value is any valid attr-list value for `:help nvim_set_hl`
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = {},
--     variables = {},
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = 'transparent', -- style for sidebars, see below
--     floats = 'transparent', -- style for floating windows
--     -- make the current line and signcolumn in the same color as the background 
--     -- so that they blend in 
--     current_line = 'transparent', 
--     sign_column = 'transparent',
--   },
-- })

vim.cmd('colorscheme tokyonight-storm')

-- -- Lua:
-- -- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme cyberdream]]


-- Make all float borders and windows transparent while keeping the theme's foreground color
local highlights = {
  "FloatBorder",
  "NormalFloat",
  "Pmenu",
  "PmenuSel",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
  "NoiceNormal",
  "NoicePopup",
  "NoiceCompletion",
  "WhichKeyFloat",
  "NotifyBackground",
}

for _, group in ipairs(highlights) do
  local success, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
  if success and hl then
    vim.api.nvim_set_hl(0, group, { fg = hl.foreground, bg = "NONE" })
  end
end
```

## File: lua/Emeric/plugins/which-key.lua
```lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      -- Set triggers to a minimal safe set. Using only <leader> avoids which-key
      -- validation errors while still enabling leader-key popups. Add more
      -- prefixes later if needed (careful with which-key's validation rules).
      -- triggers = { "<leader>", "\\" },
      show_help = true,
      show_keys = true,
      disable = {
        buftypes = {},
        filetypes = {},
      },
    })
    vim.keymap.set(
      "n",
      "<localleader>?",
      ":lua print(string.format('localleader is %s', vim.g.maplocalleader))<CR>",
      { desc = "print localleader" }
    )
  end,
}
```

## File: lua/Emeric/core/options.lua
```lua
local opt = vim.opt -- for conciseness
-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap =true -- 
opt.linebreak = true -- wrap on words
-- make the line wrap at the same column as the text width 
opt.textwidth = 80 -- wrap at 80 characters 

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive


-- cursor line
opt.cursorline = true -- highlight the current cursor line


-- appearance

opt.colorcolumn = "80" -- show a vertical line at column 80
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made 
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard = "unnamedplus" -- use system clipboard for all operations

-- Configure clipboard provider for tmux compatibility on macOS
if vim.env.TMUX then
  -- Detect macOS
  local is_macos = vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1
  
  if is_macos then
    -- Use pbcopy/pbpaste on macOS
    vim.g.clipboard = {
      name = 'macOS-clipboard',
      copy = {
        ['+'] = 'pbcopy',
        ['*'] = 'pbcopy',
      },
      paste = {
        ['+'] = 'pbpaste',
        ['*'] = 'pbpaste',
      },
      cache_enabled = 0,
    }
  else
    -- Use wl-clipboard on Linux/Wayland
    vim.g.clipboard = {
      name = 'wl-clipboard-tmux',
      copy = {
        ['+'] = {'wl-copy'},
        ['*'] = {'wl-copy'},
      },
      paste = {
        ['+'] = {'wl-paste'},
        ['*'] = {'wl-paste'},
      },
      cache_enabled = true,
    }
  end
end
-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
opt.iskeyword:append("-") -- consider string-string as whole word
```

## File: lua/Emeric/plugins/tabby.lua
```lua
return {
  "TabbyML/vim-tabby",
  config = function()
    vim.g.tabby_agent_start_command = { "npx", "tabby-agent", "--stdio" }
    vim.g.tabby_inline_completion_trigger = "manual"
    vim.g.tabby_inline_completion_keybinding_accept = "<A-Space>"
    vim.api.nvim_set_keymap('n', '<leader>te', ":let g:tabby_inline_completion_trigger='auto'<CR>",
      { noremap = true, silent = true, desc = " Enable Tabby " })
    vim.api.nvim_set_keymap('n', '<leader>td', ":let g:tabby_inline_completion_trigger='manual'<CR>",
      { noremap = true, silent = true, desc = " Disable Tabby " })
  end,
}
```

## File: lua/Emeric/plugins/treesitter.lua
```lua
return {
  "nvim-treesitter/nvim-treesitter",
	enabled = false,
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ignore_install = { "help" },
      	ensure_installed = {
		"javascript",
		"typescript",
		"c",
		"lua",
		"rust",
		"python",
		"json",
		"html",
		"css",
		"java",
		"bash",
		"haskell",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"make",
		"jsonc",
		"yaml",
		"cpp",
		"vim",
		"vimdoc",
		"query",
	},
      sync_install = true,
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      highlight = {
        enable = true,
        disable = {"latex"},
        additional_vim_regex_highlighting = { "latex", "markdown" },
      },
    }
  end,
}
```

## File: lua/Emeric/plugins/vimtex.lua
```lua
return {
  "lervag/vimtex",
  ft = { "tex", "latex", "bib" },
  config = function()
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_compiler_progname = 'nvr'
    vim.g.vimtex_view_method = 'sioyek'
    vim.api.nvim_set_hl(0, 'Conceal', { fg = '#50f97b', bg = 'none' })
    vim.g.vimtex_toc_config = {
      mode = 1,
      fold_enable = 0,
      hide_line_numbers = 1,
      resize = 0,
      refresh_always = 1,
      show_help = 1,
      show_numbers = 1,
      split_pos = 'leftabove',
      split_width = 30,
      tocdeth = 3,
      indent_levels = 1,
      todo_sorted = 1,
    }
  end,
}
```

## File: lua/Emeric/plugins/init.lua
```lua
return {
  -- Colorschemes
  require("Emeric.plugins.tokyo"),
  require("Emeric.plugins.colors"),

  -- Core
  require("Emeric.plugins.telescope"),
  require("Emeric.plugins.lualine"),
  require("Emeric.plugins.treesitter"),
  require("Emeric.plugins.autopairs"),
  require("Emeric.plugins.comment"),
  require("Emeric.plugins.gitsigns"),
  require("Emeric.plugins.indent_blankline"),
  require("Emeric.plugins.nvim-tree"),
  require("Emeric.plugins.which-key"),
  require("Emeric.plugins.trouble"),
  require("Emeric.plugins.undotree"),
  require("Emeric.plugins.fugitive"),
  require("Emeric.plugins.hop"),
  require("Emeric.plugins.barbar"),
  require("Emeric.plugins.notify"),
  require("Emeric.plugins.zenmode"),
  require("Emeric.plugins.dashboard-nvim"),
  require("Emeric.plugins.nvim-cursorline"),
  require("Emeric.plugins.rainbow-delimiters"),
  require("Emeric.plugins.surround"),
  require("Emeric.plugins.replace-with-register"),
  require("Emeric.plugins.todo-comments"),
  require("Emeric.plugins.diffview"),
  require("Emeric.plugins.git-conflict"),
  require("Emeric.plugins.nvim-web-devicons"),
  require("Emeric.plugins.telescope-fzf-native"),
  -- Copilot-related modules are lazy-managed in lua/Emeric/plugins/
  require("Emeric.plugins.luasnip"),
  require("Emeric.plugins.cmp-luasnip"),
  require("Emeric.plugins.friendly-snippets"),
  require("Emeric.plugins.neodev"),
  require("Emeric.plugins.lspsaga"),
  require("Emeric.plugins.hover"),
  require("Emeric.plugins.null-ls"),
  require("Emeric.plugins.mason-null-ls"),
  require("Emeric.plugins.nvim-dap-python"),
  require("Emeric.plugins.nvim-dap-virtual-text"),
  -- require("Emeric.plugins.treesitter-playground"),
  require("Emeric.plugins.treesitter-context"),
  require("Emeric.plugins.lazygit"),
  require("Emeric.plugins.vim-tabby"),
  require("Emeric.plugins.obsidian"),
  require("Emeric.plugins.tmux"),
  require("Emeric.plugins.img-clip"),
  require("Emeric.plugins.csvview"),
  require("Emeric.plugins.precognition"),
  require("Emeric.plugins.dressing"),
  require("Emeric.plugins.render-markdown"),
  require("Emeric.plugins.multicursor"),
  -- require("Emeric.plugins.cmp-dictionary"),
  require("Emeric.plugins.barbecue"),
  require("Emeric.plugins.colorizer"),


  -- LSP
  require("Emeric.plugins.mason"),
  require("Emeric.plugins.lsp"),
  require("Emeric.plugins.nvim-cmp"),
  require("Emeric.plugins.lspkind"),
  require("Emeric.plugins.conform"),
  require("Emeric.plugins.lsp_lines"),
  require("Emeric.plugins.jdtls"),

  -- DAP
  require("Emeric.plugins.dap"),
  require("Emeric.plugins.dapui"),
  require("Emeric.plugins.mason-nvim-dap"),

  -- AI
  require("Emeric.plugins.copilot"),
  require("Emeric.plugins.tabby"),
  require("Emeric.plugins.gen_nvim"),
  -- require("Emeric.plugins.avante"),
  require("Emeric.plugins.opencode"),

  -- Other
  -- harpoon removed
  require("Emeric.plugins.cloak"),
  require("Emeric.plugins.presence"),
  require("Emeric.plugins.lazydocker"),
  require("Emeric.plugins.refactoring"),
  require("Emeric.plugins.vimtex"),
  -- require("Emeric.plugins.neorg"),
  require("Emeric.plugins.noice"),
}
```

## File: lua/Emeric/core/keymaps.lua
```lua
-- Leader is set in init.lua to ensure it's defined before plugins load
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert Mode" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Search Highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete Character (No Register)" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" })   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Splits Equal" })  -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close Split" })    -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New Tab" })       -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close Tab" })   -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next Tab" })        --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous Tab" })    --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------
-- setup mapping to call :LazyGit
keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle Maximizer" }) -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })        -- focus file explorer
keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })      -- toggle file explorer
keymap.set("n", "<leader>ts", ":NvimTreeFindFile<CR>", { desc = "NvimTree Find File" }) -- open file explorer to current file
keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>", { desc = "NvimTree Collapse" })  -- collapse file tree


-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })            -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })              -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope Grep String" })          -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope Buffers" })                  -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope Help Tags" })              -- list available help tags
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git Commits" })          -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Telescope Git Buffer Commits" }) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git Branches" })        -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Telescope Git Status" })            -- list current changes per file with diff preview ["gs" for git status]

-- telescope git commands (not on youtube nvim video)

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary


vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Netrw Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down (Visual)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up (Visual)" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Half Page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Half Page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })


-- remap cmd s  to save without having to press :w in insert mode
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>a", { desc = "Save File (Insert Mode)" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Yanking (Visual)" })

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Line to System Clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete (No Register)" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit Insert Mode (Ctrl+C)" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Code (LSP)" })

-- Window navigation using Ctrl+h/j/k/l (useful and common mapping)
local function tmux_nav(dir_cmd, tmux_fn)
  -- dir_cmd: vim wincmd to try first (e.g. "wincmd h")
  -- tmux_fn: name of tmux.nvim helper (move_left/move_down/move_up/move_right)
  return function()
    local cur = vim.api.nvim_get_current_win()
    -- Try normal vim window movement first
    pcall(vim.cmd, dir_cmd)
    if vim.api.nvim_get_current_win() ~= cur then
      -- moved inside vim; done
      return
    end

    -- Couldn't move inside vim; if inside TMUX, try to move tmux pane
    if not vim.env.TMUX then
      return
    end

    local ok, tmux = pcall(require, "tmux")
    if ok and tmux and type(tmux[tmux_fn]) == "function" then
      pcall(tmux[tmux_fn])
      return
    end

    -- Fallback to tmux CLI if tmux.nvim isn't available
    local dir_flag_map = {
      move_left = "-L",
      move_down = "-D",
      move_up = "-U",
      move_right = "-R",
    }
    local flag = dir_flag_map[tmux_fn]
    if flag then
      pcall(vim.fn.system, { "tmux", "select-pane", flag })
    end
  end
end

vim.keymap.set("n", "<C-h>", tmux_nav("wincmd h", "move_left"), { desc = "Window Left -> Tmux Pane Left if none" })
vim.keymap.set("n", "<C-j>", tmux_nav("wincmd j", "move_down"), { desc = "Window Down -> Tmux Pane Down if none" })
vim.keymap.set("n", "<C-k>", tmux_nav("wincmd k", "move_up"), { desc = "Window Up -> Tmux Pane Up if none" })
vim.keymap.set("n", "<C-l>", tmux_nav("wincmd l", "move_right"), { desc = "Window Right -> Tmux Pane Right if none" })

-- Remap quickfix navigation to avoid colliding with Ctrl-window mappings
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix Item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List Item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous Location List Item" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace Word Under Cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make File Executable" })

-- Open current file with system default application (for PDFs, images, etc.)
vim.keymap.set("n", "<leader>o", function()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("No file to open", vim.log.levels.WARN)
    return
  end
  -- Use xdg-open on Linux, open on macOS, start on Windows
  -- Check macOS first since it's Unix-based (has("unix") returns 1 on macOS too)
  local open_cmd
  if vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    open_cmd = "xdg-open"
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    open_cmd = "start"
  else
    vim.notify("Unsupported system for opening files", vim.log.levels.ERROR)
    return
  end
  vim.fn.jobstart({ open_cmd, file_path }, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("Failed to open file with default application", vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "Open File with Default Application" })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>",
  { desc = "Edit Packer Config (Old)" });                                                                                                          -- Note: Path seems specific
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Cellular Automaton Rain" });

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source Current File" })

vim.keymap.set("n", "<leader>l", function()
  vim.cmd("lua require('lspsaga.diagnostic').show_line_diagnostics()")
end, { desc = "Show Line Diagnostics (LSPSaga)" })
-- Key mapping to toggle lsp_lines
vim.keymap.set(
  "n",                         -- normal mode
  "<Leader>l",                 -- replace <Leader>l with your preferred keybinding
  require("lsp_lines").toggle, -- toggle lsp_lines
  { desc = "Toggle lsp_lines" }
)

vim.api.nvim_set_keymap('n', 'fw', ":HopWord<CR>", { noremap = true, desc = "Hop Word" })



local conceallevel = 0
vim.keymap.set("n", "<leader>cl", function()
  print("Conceal level changed ")
  vim.api.nvim_win_set_option(0, 'conceallevel', conceallevel)
  if conceallevel == 2 then
    conceallevel = 0
  else
    conceallevel = 2
  end
end, { noremap = true, desc = "Toggle Conceal Level" })

-- CopilotChat Keymaps
local chat_keymap = vim.keymap
-- Open/Toggle/Close Chat
chat_keymap.set("n", "<leader>ccc", "<cmd>CopilotChatToggle<CR>", { desc = "CopilotChat - Toggle" })
chat_keymap.set("v", "<leader>ccc", "<cmd>CopilotChatToggle<CR>", { desc = "CopilotChat - Toggle (Visual)" }) -- Often useful to toggle from visual mode
chat_keymap.set("n", "<leader>cco", "<cmd>CopilotChatOpen<CR>", { desc = "CopilotChat - Open" })
chat_keymap.set("n", "<leader>ccx", "<cmd>CopilotChatClose<CR>", { desc = "CopilotChat - Close" })

-- Quick Prompt Shortcuts (Examples - requires defining these prompts in setup or using defaults)
chat_keymap.set("n", "<leader>cce", "<cmd>CopilotChatExplain<CR>", { desc = "CopilotChat - Explain Code" })
chat_keymap.set("n", "<leader>cct", "<cmd>CopilotChatTests<CR>", { desc = "CopilotChat - Generate Tests" })
chat_keymap.set("n", "<leader>ccf", "<cmd>CopilotChatFix<CR>", { desc = "CopilotChat - Fix Code" })
chat_keymap.set("n", "<leader>ccr", "<cmd>CopilotChatReview<CR>", { desc = "CopilotChat - Review Code" })

-- Visual Mode Prompts (Send selection to chat)
chat_keymap.set("v", "<leader>cce", ":CopilotChatExplain<CR>", { desc = "CopilotChat - Explain Selection" })
chat_keymap.set("v", "<leader>cct", ":CopilotChatTests<CR>", { desc = "CopilotChat - Tests for Selection" })
chat_keymap.set("v", "<leader>ccf", ":CopilotChatFix<CR>", { desc = "CopilotChat - Fix Selection" })
chat_keymap.set("v", "<leader>ccr", ":CopilotChatReview<CR>", { desc = "CopilotChat - Review Selection" })

-- Other useful commands
chat_keymap.set("n", "<leader>ccp", "<cmd>CopilotChatPrompts<CR>", { desc = "CopilotChat - Select Prompt" })
chat_keymap.set("n", "<leader>cca", "<cmd>CopilotChatAgents<CR>", { desc = "CopilotChat - Select Agent" })
chat_keymap.set("n", "<leader>ccm", "<cmd>CopilotChatModels<CR>", { desc = "CopilotChat - Select Model" })
chat_keymap.set("n", "<leader>ccs", "<cmd>CopilotChatStop<CR>", { desc = "CopilotChat - Stop Response" })
chat_keymap.set("n", "<leader>ccz", "<cmd>CopilotChatReset<CR>", { desc = "CopilotChat - Reset Chat" })


local latex_keymap = vim.keymap

latex_keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<CR>", { desc = "Vimtex - Compile" })
latex_keymap.set("n", "<localleader>lv", "<cmd>VimtexView<CR>", { desc = "Vimtex - View PDF" })
latex_keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<CR>", { desc = "Vimtex - View Errors" })
latex_keymap.set("n", "<localleader>lk", "<cmd>VimtexStop<CR>", { desc = "Vimtex - Stop Compilation" })
latex_keymap.set("n", "<localleader>li", "<cmd>VimtexInfo<CR>", { desc = "Vimtex - Show Info" })
latex_keymap.set("n", "<localleader>ls", "<cmd>VimtexTocOpen<CR>", { desc = "Vimtex - Open TOC" })
latex_keymap.set("n", "<localleader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "Vimtex - Toggle TOC" })
latex_keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<CR>", { desc = "Vimtex - Clean Aux Files" })
latex_keymap.set("n", "<localleader>lC", "<cmd>VimtexClean!<CR>", { desc = "Vimtex - Clean Full" })
latex_keymap.set("n", "<localleader>lm", "<cmd>VimtexImaps<CR>", { desc = "Vimtex - List Imaps" })
latex_keymap.set("n", "<localleader>lq", "<cmd>VimtexLog<CR>", { desc = "Vimtex - Show Log" })
```

## File: lua/Emeric/plugins/mason.lua
```lua
return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		-- Simple, robust mason + mason-lspconfig setup.
		local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
		local servers = {
			"bashls",
			"clangd",
			"cssls",
			"dockerls",
			"gopls",
			"html",
			"jsonls",
			"lua_ls",
			"marksman",
			"omnisharp",
			"perlnavigator",
			"phpactor",
			"pyright",
			"rust_analyzer",
			"sqls",
			"texlab",
			"ts_ls",
			"yamlls",
		}
		if ok and type(lsp_setup.servers) == "table" then servers = lsp_setup.servers end

		require("mason").setup()

		local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
		if ok_mlsp and mlsp and type(mlsp.setup) == "function" then
			local opts = { automatic_installation = true }
			if #servers > 0 then opts.ensure_installed = servers end
			pcall(mlsp.setup, opts)

			-- Use vim.lsp.config instead of require('lspconfig') for Neovim 0.11+
			-- Fallback to require('lspconfig') for older versions
			local lspconfig
			if vim.lsp and vim.lsp.config then
				lspconfig = vim.lsp.config
			else
				local ok_lsp, lspconfig_req = pcall(require, "lspconfig")
				if ok_lsp then
					lspconfig = lspconfig_req
				end
			end

			if lspconfig then
				for _, srv in ipairs(servers) do
					local cfg = {}
					if ok and type(lsp_setup.on_attach) == "function" then
						cfg.on_attach = lsp_setup.on_attach
					end
					if ok and type(lsp_setup.lsp_flags) == "table" then
						cfg.flags = lsp_setup.lsp_flags
					end

					if lspconfig[srv] and type(lspconfig[srv].setup) == "function" then
						local setup_ok, setup_err = pcall(lspconfig[srv].setup, cfg)
						if not setup_ok then
							vim.notify("Failed to setup LSP server: " .. srv .. " - " .. tostring(setup_err), vim.log.levels.WARN)
						end
					end
				end
			end
		else
			vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
		end
	end,
}
```

## File: lua/Emeric/plugins/copilot.lua
```lua
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- lazy-load-friendly: only load on Copilot command so mappings that call
  -- Copilot work even before the plugin is fetched/loaded by lazy.
  init = function()
    -- Key mappings (use Vim commands to be safe with lazy-loading)
    vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { noremap = true, silent = true, desc = "Enable Copilot" })
    vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>Copilot disable<CR>', { noremap = true, silent = true, desc = "Disable Copilot" })

    -- Toggle auto-trigger helper (works once Copilot is loaded)
    local function toggle_copilot_auto_trigger()
      local success, copilot_suggestion = pcall(require, "copilot.suggestion")
      if success then
        copilot_suggestion.toggle_auto_trigger()
      else
        vim.notify("Copilot plugin not loaded yet.", vim.log.levels.WARN)
      end
    end
    vim.api.nvim_set_keymap('n', '<Leader>ct', '<cmd>lua toggle_copilot_auto_trigger()<CR>', { noremap = true, silent = true, desc = "Toggle Copilot AutoTrigger" })
  end,
  config = function()
    -- Auto-detect Node.js path based on OS
    local node_command = nil
    local home = vim.fn.expand("$HOME")
    
    -- Try to find node using which command first (more reliable for nvm)
    local which_result = vim.fn.system("which node 2>/dev/null"):gsub("%s+", "")
    if which_result ~= "" and vim.fn.executable(which_result) == 1 then
      node_command = which_result
    else
      -- Fallback: try common paths based on OS
      local paths = {}
      
      if vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1 then
        -- macOS paths
        paths = {
          home .. "/.nvm/versions/node/v22.17.0/bin/node",
          "/usr/local/bin/node",
          "/opt/homebrew/bin/node",
        }
      else
        -- Linux paths
        paths = {
          home .. "/.nvm/versions/node/v24.9.0/bin/node",
          home .. "/.nvm/versions/node/v22.17.0/bin/node",
          "/usr/bin/node",
        }
      end
      
      for _, path in ipairs(paths) do
        if vim.fn.executable(path) == 1 then
          node_command = path
          break
        end
      end
    end
    
    require("copilot").setup({
      copilot_node_command = node_command or "node", -- Use detected path or fallback to 'node' in PATH
      suggestion = { enabled = false, auto_trigger = false },
      panel = { enabled = false },
      filetypes = { markdown = true },
    })
  end,
}
```

## File: lua/Emeric/plugins/nvim-cmp.lua
```lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    -- "uga-rosa/cmp-dictionary",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    -- local dict = require("cmp-dictionary")

    require("luasnip/loaders/from_vscode").lazy_load()

    vim.opt.completeopt = "menu,menuone,noselect"

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    -- dict.setup({ dic = { ["*"] = {} } })

    -- local function setup_dictionary()
    --   local cwd = vim.fn.getcwd()
    --   if cwd:find("/oreade_cafe/mobile%-app", 1, true) then
    --     local files = vim.fn.glob(cwd .. "/assets/locales/**/*.json", true, true)
    --     if #files > 0 then
    --       dict.setup({ dic = { ["*"] = files } })
    --     else
    --       dict.setup({ dic = { ["*"] = {} } })
    --       vim.notify("cmp-dictionary: no JSON files found in assets/locales", vim.log.levels.WARN)
    --     end
    --   else
    --     dict.setup({ dic = { ["*"] = {} } })
    --   end
    -- end
    --
    -- setup_dictionary()

    -- vim.api.nvim_create_autocmd("DirChanged", {
    --   callback = setup_dictionary,
    -- })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<M-k>"] = cmp.mapping.select_prev_item(),
        ["<M-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif has_words_before() then
            fallback()
          else
            fallback()
          end
        end),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp",        group_index = 2 },
        { name = "luasnip",         group_index = 1 },
        { name = "buffer",          group_index = 4 },
        { name = "path",            group_index = 4 },
        { name = "render-markdown", group_index = 4 },
        { name = "copilot",         group_index = 3 },
        -- { name = "dictionary",      keyword_length = 2, group_index = 5 },
      }),
      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          scrollbar = false,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          if entry.source.name == "copilot" then
            vim_item.kind = ""
          else
            vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = false })
          end

          vim_item.menu = ({
            nvim_lsp = "LSP",
            luasnip = "Snippet",
            buffer = "Buffer",
            path = "Path",
            copilot = "Copilot",
          })[entry.source.name]

          return vim_item
        end,
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
```

## File: lua/Emeric/plugins/lsp.lua
```lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
		if not ok then
			vim.notify("Emeric.lsp_setup not found; LSP keymaps may be incomplete", vim.log.levels.WARN)
			return
		end

		local on_attach = lsp_setup.on_attach
		local lsp_flags = lsp_setup.lsp_flags

		-- Diagnostics keymaps
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Diagnostics Float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go To Previous Diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go To Next Diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set Diagnostics Loclist" })

		-- helper to show active client
		local function get_active_lsp_client()
			local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
			if #clients == 0 then
				return nil
			else
				return clients[1]
			end
		end

		local function print_active_lsp_client()
			local client = get_active_lsp_client()
			if client then
				print("Active LSP client: " .. client.name)
			else
				print("No active LSP client")
			end
		end

		vim.keymap.set("n", "<space>lp", print_active_lsp_client, { desc = "Print Active LSP Client" })
	end,
}
```

## File: init.lua
```lua
-- Set leader before plugins / lazy.nvim load so plugin setup can reference it
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
```
