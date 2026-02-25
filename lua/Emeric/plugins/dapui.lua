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
