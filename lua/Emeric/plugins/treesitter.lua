return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = function()
    -- Compiler preference for parser compilation
    require('nvim-treesitter.install').compilers = { "gcc-15", "cc", "clang" }

    -- Install parsers not bundled with Neovim 0.12
    -- (Common ones like lua, vim, python, c, markdown are already included)
    require("nvim-treesitter").install({
      "bibtex",
    })

    -- Disable treesitter for LaTeX so VimTeX handles syntax
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "latex" or ft == "tex" then
          return
        end
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}