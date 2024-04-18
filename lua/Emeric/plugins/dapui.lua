		--
		--
		local dap = require('dap')
		local dapui = require('dapui')

		dap.listeners.after.event_initialized['dapui_config'] = function() 
      dapui.open()
    end
		dap.listeners.before.event_terminated['dapui_config'] = function() 
      dapui.close()
    end
		dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close
    end

		dapui.setup({
			floating = {
				border = 'rounded',
			},
		})
		--
		-- Key mappings
		vim.keymap.set('n', '<leader>du', function()
			dapui.toggle()
		end, { desc = 'Dap UI' })

		vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
			dapui.eval()
		end, { desc = 'Eval' })
