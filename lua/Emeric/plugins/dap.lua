local dap = require('dap')
local dapui = require('dapui')
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
-- Configure DAP UI
dapui.setup({
  -- Here you can configure the layout and elements of DAP UI
  -- This is a basic setup with two windows: a sidebar and a tray at the bottom
  layouts = {
    {
      elements = {
        -- Elements can be 'scopes', 'breakpoints', 'stacks', 'watches', 'repl'
        { id = 'scopes', size = 0.25 },
        'breakpoints',
        { id = 'stacks', size = 0.25 },
        'watches',
      },
      size = 40, -- The width of the sidebar
      position = 'left', -- The side of the screen it's on
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10, -- The height of the tray
      position = 'bottom', -- The bottom of the screen
    },
  },
  -- Other configurations like floating window settings and keymaps
})

-- Automatically open the DAP UI when starting a debug session
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

-- Automatically close the DAP UI when the debug session is terminated
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Add your debug configurations for different languages below
-- For example, here is a simple configuration for Python using debugpy
dap.configurations.python = {
  {
    type = 'python', -- the type here must match the name of the dap adapter
    request = 'launch',
    name = "Launch file",
    program = "${file}", -- This will use the file in the current buffer
    pythonPath = function()
      -- Path to the python executable. Adjust as needed.
      return '/usr/bin/python3'
    end,
  },
}
-- You would add similar configurations for other languages you are working with

-- Key mappings for common DAP operations can go here
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lp', '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true })
