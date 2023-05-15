--[[vim.g.copilot_filetypes = {
  ['*'] = true, -- enable GitHub Copilot for all file types by default
  ['java'] = false,
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
}--]]
-- Set up mappings to enable and disable Copilot
vim.api.nvim_set_keymap('n', '<Leader>ce', ':Copilot enable<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true })

