return {
  "yamatsum/nvim-cursorline",
  config = function()
    local ok, cursorline = pcall(require, 'nvim-cursorline')
    if not ok then
      vim.notify("Failed to load nvim-cursorline", vim.log.levels.WARN)
      return
    end

    cursorline.setup {
      cursorline = {
        enable = true,
        timeout = 0,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { },
      }
    }

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo.binary then
          vim.wo.cursorline = false
          pcall(vim.api.nvim_clear_autocmds, { buffer = buf, group = "nvim-cursorline" })
        end
      end,
    })
  end,
}
