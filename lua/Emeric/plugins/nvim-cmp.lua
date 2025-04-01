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

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
})
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
    ["<M-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion (Option + k)
    ["<M-j>"] = cmp.mapping.select_next_item(), -- Next suggestion (Option + j)
    ["<Fn-k>"] = cmp.mapping.select_prev_item(),
    ["<Fn-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),            -- Show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
  }),
  sources = cmp.config.sources({
    { name = "copilot",         group_index = 2 },
    { name = "nvim_lsp",        group_index = 2 },
    { name = "luasnip",         group_index = 2 },
    { name = "buffer",          group_index = 2 },
    { name = "path",            group_index = 2 },
    { name = "render-markdown", group_index = 2 },
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
