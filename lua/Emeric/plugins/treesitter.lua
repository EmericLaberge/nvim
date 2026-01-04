return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Use the new rewrite
  lazy = false,
  config = function()
    require('nvim-treesitter.install').compilers = { "gcc-15", "cc", "clang" }
    -- 1. Install Parsers Manually
    -- The "ensure_installed" option is gone. You must explicitly call install.
    require("nvim-treesitter").install({
      "c", "lua", "vim", "vimdoc", "query",
      "markdown", "markdown_inline", "python",
      "latex", "bibtex"
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- DISABLE treesitter for latex to let VimTeX handle syntax
        if vim.bo[args.buf].filetype == "latex" or vim.bo[args.buf].filetype == "tex" then
          return
        end

        -- Enable native Highlighting for everything else
        local ok = pcall(vim.treesitter.start, args.buf)

        -- Enable native Indentation
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
