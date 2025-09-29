return {
  "xuhdev/vim-latex-live-preview",
  config = function()
    vim.g.livepreview_previewer = 'skim'
    vim.g.livepreview_engine='latexmk'
  end,
}
