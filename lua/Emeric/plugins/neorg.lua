require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = { notes = "~/notes" },
        default_workspace = "notes",
      }
    }
  }
}
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})
vim.cmd [[
  hi NeorgHeading1 guifg=#FF5733 gui=bold
  hi NeorgHeading2 guifg=#33FF57 gui=bold
  hi NeorgHeading3 guifg=#3357FF gui=bold
  hi NeorgListBullet1 guifg=#F0F033 gui=bold
  hi NeorgListBullet2 guifg=#33F0F0 gui=bold
]]
