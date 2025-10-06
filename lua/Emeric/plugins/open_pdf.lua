local function open_pdf_in_sioyek()
  local current_file = vim.fn.expand('%:p') -- Get full path of the current file

  -- Check if the file ends with .pdf (case-insensitive)
  if string.match(current_file, '%.pdf$') then
    local cmd = 'sioyek "' .. current_file .. '"'
    -- Run Sioyek asynchronously in the background
    vim.fn.jobstart(cmd, { detach = true })
    vim.notify("Opening " .. vim.fn.fnamemodify(current_file, ":t") .. " in Sioyek", vim.log.levels.INFO)
  else
    vim.notify("Current file is not a PDF", vim.log.levels.WARN)
  end
end

-- Map <leader>op to open the PDF in Sioyek (in Normal mode)
vim.keymap.set('n', '<leader>op', open_pdf_in_sioyek, { noremap = true, silent = true, desc = "Open PDF in Sioyek" })

-- Optional: You could also add an autocommand to suggest opening on buffer enter
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.pdf",
  callback = function()
    -- Maybe just notify the user they *can* open it with <leader>op
    vim.notify("PDF detected. Press <leader>op to open in Sioyek.", vim.log.levels.INFO, {title = "PDF Viewer"})
  end,
})
