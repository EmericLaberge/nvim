return {
  "lervag/vimtex",
  ft = { "tex", "latex", "bib" },
  config = function()
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_compiler_progname = 'nvr'
    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_view_general_viewer = 'sioyek'
    vim.g.vimtex_view_general_options = '--reuse-window --forward-search-file @tex --forward-search-line @line @pdf'
    vim.g.vimtex_view_sioyek_options = '--reuse-window > /dev/null 2>&1'
    vim.g.vimtex_toc_config = {
      mode = 1,
      fold_enable = 0,
      hide_line_numbers = 1,
      resize = 0,
      refresh_always = 1,
      show_help = 1,
      show_numbers = 1,
      split_pos = 'leftabove',
      split_width = 30,
      tocdeth = 3,
      indent_levels = 1,
      todo_sorted = 1,
    }

    -- Vimtex keymaps
    vim.keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<CR>", { desc = "Vimtex - Compile" })
    vim.keymap.set("n", "<localleader>lv", "<cmd>VimtexView<CR>", { desc = "Vimtex - View PDF" })
    vim.keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<CR>", { desc = "Vimtex - View Errors" })
    vim.keymap.set("n", "<localleader>lk", "<cmd>VimtexStop<CR>", { desc = "Vimtex - Stop Compilation" })
    vim.keymap.set("n", "<localleader>li", "<cmd>VimtexInfo<CR>", { desc = "Vimtex - Show Info" })
    vim.keymap.set("n", "<localleader>ls", "<cmd>VimtexTocOpen<CR>", { desc = "Vimtex - Open TOC" })
    vim.keymap.set("n", "<localleader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "Vimtex - Toggle TOC" })
    vim.keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<CR>", { desc = "Vimtex - Clean Aux Files" })
    vim.keymap.set("n", "<localleader>lC", "<cmd>VimtexClean!<CR>", { desc = "Vimtex - Clean Full" })
    vim.keymap.set("n", "<localleader>lm", "<cmd>VimtexImaps<CR>", { desc = "Vimtex - List Imaps" })
    vim.keymap.set("n", "<localleader>lq", "<cmd>VimtexLog<CR>", { desc = "Vimtex - Show Log" })
  end,
}