return {
  "williamboman/mason-nvim-dap.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require('mason-nvim-dap').setup({
      ensure_installed = { 'debugpy' },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = "executable",
            command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
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