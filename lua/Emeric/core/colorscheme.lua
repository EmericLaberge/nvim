-- TokyoNight theme (loaded from plugins)
--   style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--   transparent = true, -- Enable this to disable setting the background color
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--   styles = {
--     -- Style to be applied to different syntax groups
--     -- Value is any valid attr-list value for `:help nvim_set_hl`
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = {},
--     variables = {},
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = 'transparent', -- style for sidebars, see below
--     floats = 'transparent', -- style for floating windows
--     -- make the current line and signcolumn in the same color as the background 
--     -- so that they blend in 
--     current_line = 'transparent', 
--     sign_column = 'transparent',
--   },
-- })

vim.cmd('colorscheme tokyonight-storm')

-- -- Lua:
-- -- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme cyberdream]]


-- Make all float borders and windows transparent while keeping the theme's foreground color
local highlights = {
  "FloatBorder",
  "NormalFloat",
  "Pmenu",
  "PmenuSel",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
  "NoiceNormal",
  "NoicePopup",
  "NoiceCompletion",
  "WhichKeyFloat",
}

for _, group in ipairs(highlights) do
  local success, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
  if success and hl then
    vim.api.nvim_set_hl(0, group, { fg = hl.foreground, bg = "NONE" })
  end
end

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })

-- Highlight minimal pour les références LSP (quand tu hover sur un mot en normal mode)
-- Fond transparent pour ne pas distraire
vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#7AA2F7", bold = false, italic = false })
vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#7AA2F7", bold = false, italic = false })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#7AA2F7", bold = false, italic = false })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7" })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7aa2f7" })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7aa2f7" })
