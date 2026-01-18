local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg =true, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights see `:h synIDattr`
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
  },
})

-- require('tokyonight').setup({
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
  "NotifyBackground",
}

for _, group in ipairs(highlights) do
  local success, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
  if success and hl then
    vim.api.nvim_set_hl(0, group, { fg = hl.foreground, bg = "NONE" })
  end
end

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7" })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7aa2f7" })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7aa2f7" })
