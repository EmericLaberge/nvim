		return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local dapui = require("dapui")
    dapui.setup({
      floating = {
        border = 'rounded',
      },
    })
    vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = 'Dap UI' })
    vim.keymap.set({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, { desc = 'Eval' })
  end,
}
