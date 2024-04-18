		local dap = require('dap')
		local dapui = require('dapui')

		dap.listeners.after.event_initialized['dapui_config'] = function()
			dapui.open() end
		dap.listeners.before.event_terminated['dapui_config'] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited['dapui_config'] = function()
			dapui.close()
		end

		dapui.setup({
			floating = {
				border = 'rounded',
			},
		})

    vim.keymap.set('n','<leader>dc', function()
      dap.continue()
    end, { desc = 'Continue' })

    vim.keymap.set('n','<leader>ds', function()
      dap.step_over()
    end, { desc = 'Step Over' })

    vim.keymap.set('n','<leader>di', function()
      dap.step_into()
    end, { desc = 'Step Into' })

    vim.keymap.set('n','<leader>do', function()
      dap.step_out()
    end, { desc = 'Step Out' })

    vim.keymap.set('n','<leader>dt', function()
      dap.toggle_breakpoint()
    end, { desc = 'Toggle Breakpoint' })

    vim.keymap.set('n','<leader>dr', function()
      dap.repl.open()
    end, { desc = 'Open REPL' })

    vim.keymap.set('n','<leader>dl', function()
      dap.run_last()
    end, { desc = 'Run Last' })


    vim.keymap.set('n','<leader>db', function()
      dap.toggle_breakpoint()
    end, { desc = 'Toggle Breakpoint' })

    vim.keymap.set('n','<leader>dB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Set Breakpoint' })
      

		-- Key mappings
		vim.keymap.set('n', '<leader>du', function()
			dapui.toggle()
		end, { desc = 'Dap UI' })

		vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
			dapui.eval()
		end, { desc = 'Eval' })
