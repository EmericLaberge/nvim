return {
  "lervag/vimtex",
  ft = { "tex", "latex", "bib" },
  config = function()
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_compiler_progname = 'nvr'
    vim.g.vimtex_view_method = 'sioyek'
    vim.api.nvim_set_hl(0, 'Conceal', { fg = '#50f97b', bg = 'none' })
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
  end,
}
