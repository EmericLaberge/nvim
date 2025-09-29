return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    local hop = require('hop')
    -- Ensure Hop is initialized before using its API
    hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

    local directions = require('hop.hint').HintDirection
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop Char1 After Cursor" })
    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop Char1 Before Cursor" })
  end,
}

