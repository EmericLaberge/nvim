-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert Mode" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Search Highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete Character (No Register)" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertically" })        -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontally" })        -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Splits Equal" })        -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close Split" })    -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New Tab" })   -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close Tab" }) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next Tab" })     --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous Tab" })     --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------
-- setup mapping to call :LazyGit
keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle Maximizer" }) -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })    -- focus file explorer
keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })   -- toggle file explorer
keymap.set("n", "<leader>ts", ":NvimTreeFindFile<CR>", { desc = "NvimTree Find File" }) -- open file explorer to current file
keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>", { desc = "NvimTree Collapse" }) -- collapse file tree


-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })    -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })     -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope Grep String" })   -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope Buffers" })       -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope Help Tags" })     -- list available help tags
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope Git Commits" })   -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Telescope Git Buffer Commits" }) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope Git Branches" })  -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Telescope Git Status" })    -- list current changes per file with diff preview ["gs" for git status]

-- telescope git commands (not on youtube nvim video)

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Netrw Explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down (Visual)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up (Visual)" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Half Page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Half Page" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })


-- remap cmd s  to save without having to press :w in insert mode
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>a", { desc = "Save File (Insert Mode)" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Yanking (Visual)" })

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Line to System Clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete (No Register)" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit Insert Mode (Ctrl+C)" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Code (LSP)" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix Item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List Item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous Location List Item" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word Under Cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make File Executable" })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>", { desc = "Edit Packer Config (Old)" }); -- Note: Path seems specific
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Cellular Automaton Rain" });

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source Current File" })

vim.keymap.set("n", "<leader>l", function()
  vim.cmd("lua require('lspsaga.diagnostic').show_line_diagnostics()")
end, { desc = "Show Line Diagnostics (LSPSaga)" })
-- Key mapping to toggle lsp_lines
vim.keymap.set(
  "n",                         -- normal mode
  "<Leader>l",                 -- replace <Leader>l with your preferred keybinding
  require("lsp_lines").toggle, -- toggle lsp_lines
  { desc = "Toggle lsp_lines" }
)

vim.api.nvim_set_keymap('n', 'fw', ":HopWord<CR>", { noremap = true, desc = "Hop Word" })



local conceallevel = 0
vim.keymap.set("n", "<leader>cl", function()
  print("Conceal level changed ")
  vim.api.nvim_win_set_option(0, 'conceallevel', conceallevel)
  if conceallevel == 2 then
    conceallevel = 0
  else
    conceallevel = 2
  end
end, { noremap = true, desc = "Toggle Conceal Level" })


