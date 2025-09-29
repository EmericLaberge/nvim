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
                name = "JavaSE-1.8",
                path = "/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home",
                default = true,
              },
              {
                name = "JavaSE-17",
                path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
              },
              {
                name = "JavaSE-19",
                path = "/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home",
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

    vim.lsp.start({
      name = "jdtls",
      cmd = setup().cmd,
      root_dir = setup().root_dir,
      on_attach = setup().on_attach,
      capabilities = setup().capabilities,
    })
  end,
}
