return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Mason bin dans le PATH (linters, formatters, etc.)
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
    if ok and type(lsp_setup.servers) == "table" then
      servers = lsp_setup.servers
    end

    require("mason").setup()

    local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
    if ok_mlsp and mlsp and type(mlsp.setup) == "function" then
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
        automatic_enable = false, -- on configure nous‑mêmes via lspconfig ci‑dessous
      })

      local lspconfig = require("lspconfig")
      for _, srv in ipairs(servers) do
        local cfg = {
          capabilities = capabilities,
        }
        if ok and type(lsp_setup.on_attach) == "function" then
          cfg.on_attach = lsp_setup.on_attach
        end
        if ok and type(lsp_setup.lsp_flags) == "table" then
          cfg.flags = lsp_setup.lsp_flags
        end

        if lspconfig[srv] and type(lspconfig[srv].setup) == "function" then
          local setup_ok, setup_err = pcall(lspconfig[srv].setup, cfg)
          if not setup_ok then
            vim.notify(
              "Failed to setup LSP server: " .. srv .. " - " .. tostring(setup_err),
              vim.log.levels.WARN
            )
          end
        end
      end
    else
      vim.notify("mason-lspconfig not available; skipping ensure_installed", vim.log.levels.WARN)
    end
  end,
}
