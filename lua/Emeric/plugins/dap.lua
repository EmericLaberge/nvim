-- lua/Emeric/plugins/dap.lua
local dap = require('dap')
local dapui = require('dapui')

-- Configure debuggers here
-- For example, here's a configuration for a Python debugger
dap.adapters.python = {
  type = 'executable';
  command = '/usr/bin/python3'; -- Replace with the path to your Python executable
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The name of the configuration
    name = "Launch file",
    type = 'python', -- The type here should match the adapter type
    request = 'launch',
    program = "${file}", -- This will start the file you are currently editing
    pythonPath = function()
      -- Update this path to match the path to your Python interpreter
      return '/usr/bin/python'
    end,
  },
}

-- Other language configurations go here

-- Optionally, you can also set up mappings for `nvim-dap` commands
vim.fn.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
-- Add more mappings as needed

return dap

