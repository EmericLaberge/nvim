return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Use the new rewrite
  lazy = false,
  config = function()
    -- 1. Install Parsers Manually
    -- The "ensure_installed" option is gone. You must explicitly call install.
    require("nvim-treesitter").install({
      "c", "lua", "vim", "vimdoc", "query", 
      "markdown", "markdown_inline", "python",
      "latex", "bibtex"
    })

    -- 2. Enable Highlighting & Indentation
    -- The plugin no longer does this for you. You must use an autocommand
    -- to start the native treesitter engine when opening a file.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- Enable native Highlighting
        local ok = pcall(vim.treesitter.start, args.buf)
        
        -- Enable native Indentation (if highlighting worked)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
