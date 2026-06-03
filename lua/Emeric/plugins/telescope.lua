return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        preview = {
          treesitter = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    pcall(telescope.load_extension, "fzf")

    local builtin = require('telescope.builtin')

    -- File finding
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git Files" })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep String (input)" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = "Grep String Under Cursor" })

    -- Navigation
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })

    -- Git
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git Commits" })
    vim.keymap.set('n', '<leader>gfc', builtin.git_bcommits, { desc = "Git Buffer Commits" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git Branches" })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git Status" })
  end,
}