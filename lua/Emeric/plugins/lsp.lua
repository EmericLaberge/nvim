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
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {
      settings = {
        ['rust-analyzer'] = {},
      },
    }
    lspconfig.phpactor.setup {
      init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
      }
    }
    lspconfig.perlpls.setup {}
    lspconfig.scheme_langserver.setup {
      cmd = { "run", "/tmp/scheme-langserver.log", "enable", "disable" },
      filetypes = { "scheme", "scm", "sld", "sls", "sps" },
      root_dir = lspconfig.util.root_pattern(".git", "AKKU.manifest", "."),
    }

    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Open Diagnostics Float" })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go To Previous Diagnostic" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go To Next Diagnostic" })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Set Diagnostics Loclist" })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local builtin = require('telescope.builtin')
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = ev.buf, desc = "Go To Definition" })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = ev.buf, desc = "Go To References" })
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = ev.buf, desc = "Go To Implementation" })
        vim.keymap.set('n', '<space>D', builtin.lsp_type_definitions, { buffer = ev.buf, desc = "Go To Type Definition" })
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { buffer = ev.buf, desc = "Document Symbols" })
        vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, { buffer = ev.buf, desc = "Workspace Symbols" })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go To Declaration" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, { buffer = ev.buf, desc = "Format Code" })
      end,
    })

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

    vim.keymap.set('n', '<space>lp', print_active_lsp_client, { desc = "Print Active LSP Client" })
  end,
}
