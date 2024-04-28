require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ignore_install = { "help" }, -- List of parsers to ignore installing
  ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust", "python", "json", "html", "css", "java", "bash", "haskell" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,
  -- -- rainbow = {
  --   -- enable = true,
  --
  --   max_file_lines = 3000,
  -- query = 'rainbow-parens',
  --   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  -- },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    disable = {"latex"},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "latex", "markdown" },
  },
}
