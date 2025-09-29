return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local map = vim.api.nvim_set_keymap
    map('n', '<A-;>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Buffer Previous" })
    map('n', '<A-\'>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "Buffer Next" })
    map('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = "Buffer Move Previous" })
    map('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = "Buffer Move Next" })
    map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "Buffer Goto 1" })
    map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "Buffer Goto 2" })
    map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "Buffer Goto 3" })
    map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "Buffer Goto 4" })
    map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "Buffer Goto 5" })
    map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "Buffer Goto 6" })
    map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "Buffer Goto 7" })
    map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "Buffer Goto 8" })
    map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "Buffer Goto 9" })
    map('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true, desc = "Buffer Last" })
    map('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "Buffer Pin" })
    map('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Buffer Close" })
    map('n', '<C-p>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true, desc = "Buffer Pick" })
    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { noremap = true, silent = true, desc = "Buffer Order By Number" })
    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', { noremap = true, silent = true, desc = "Buffer Order By Directory" })
    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', { noremap = true, silent = true, desc = "Buffer Order By Language" })
    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { noremap = true, silent = true, desc = "Buffer Order By Window" })
  end,
}
