-- Import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

-- Import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

-- Import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- Load VS Code-like snippets from plugins (e.g., friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),            -- Show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
  }),
  sources = cmp.config.sources({
  { name = "luasnip",  group_index = 1 }, -- Snippets first
    { name = "copilot",  group_index = 2 },
    { name = "nvim_lsp", group_index = 3 },
    { name = "path",     group_index = 4 },
    { name = "buffer",   group_index = 5 },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})
