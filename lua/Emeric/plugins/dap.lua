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


    -- Signs Codicons
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' }) -- Simple cercle (test)
    vim.fn.sign_define('DapBreakpointCondition', { text = '?', texthl = 'DapBreakpointCondition' })
    vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '➤', texthl = 'DapStopped', linehl = 'DapStoppedLine' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '✗', texthl = 'DapBreakpointRejected' })

    -- Highlight groups
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#F7768E' })          -- rouge
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#E0AF68' }) -- jaune/orange
    vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#7AA2F7' })            -- bleu
    vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#9ECE6A' })             -- vert
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2E3D28' })         -- fond vert foncé pour la ligne courante
    vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#565F89' })  -- gris

    -- Python adapter (debugpy)
    dap.adapters.python = {
      type = 'executable',
      command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          local venv = os.getenv('VIRTUAL_ENV')
          if venv then
            return venv .. '/bin/python'
          end
          local cwd_venv = vim.fn.getcwd() .. '/.venv/bin/python'
          if vim.fn.executable(cwd_venv) == 1 then
            return cwd_venv
          end
          return 'python3'
        end,
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file with arguments',
        program = '${file}',
        args = function()
          local input = vim.fn.input('Arguments: ')
          return vim.split(input, ' ', { trimempty = true })
        end,
        pythonPath = function()
          local venv = os.getenv('VIRTUAL_ENV')
          if venv then
            return venv .. '/bin/python'
          end
          return 'python3'
        end,
      },
    }

    vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>ds', function() dap.step_over() end, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>do', function() dap.step_out() end, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>dt', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Open REPL' })
    vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
    vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      { desc = 'Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
      { desc = 'Log Point' })
  end,
}
