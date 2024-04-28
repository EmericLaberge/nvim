vim.g.copilot_filetypes = {
  --[[['java'] = false,
  ['python'] = false,
  ['python3'] = false,
  ['python2'] = false,
  ['javascript'] = false,
  ['javascriptreact'] = false,
  ['typescript'] = false,
  ['typescriptreact'] = false,
  ['c'] = false,
  ['cpp'] = false,
  ['c++'] = false,
  ['c#'] = false,
  ['go'] = false,
  ['rust'] = false,
  ['julia'] = false,
  ]]--
  ['*'] = false,
}
-- Set up mappings to enable and disable Copilot
-- Function to enable GitHub Copilot for the current buffer
function EnableCopilotForBuffer()
  vim.api.nvim_buf_set_var(0, 'copilot_enabled', true)
end

-- Function to disable GitHub Copilot for the current buffer
function DisableCopilotForBuffer()
  vim.api.nvim_buf_set_var(0, 'copilot_enabled', false)
end

-- Set up mappings to enable and disable Copilot for the current buffer
vim.api.nvim_set_keymap('n', '<Leader>ce', '<cmd>lua EnableCopilotForBuffer()<CR>', { noremap = true, silent = true, desc = "Enable Copilot"})
vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd>lua DisableCopilotForBuffer()<CR>', { noremap = true, silent = true, desc = "Disable Copilot"})
