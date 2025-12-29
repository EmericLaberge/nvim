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
