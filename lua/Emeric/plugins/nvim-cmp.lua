-- Import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

-- Import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  -- luasnip is not strictly required for cmp to work,
  -- but expansion won't work without it.
  -- You might want to log an error or simply proceed without snippet expansion.
  -- print("Error: luasnip not found")
end

-- Import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")

--Import cmp_dictionary
local dict_status, dict = pcall(require, "cmp_dictionary")
if not lspkind_status then
  -- lspkind is optional for formatting.
  -- print("Warning: lspkind not found, using default formatting.")
end

-- Load VS Code-like snippets if luasnip is available
if luasnip_status then
  require("luasnip/loaders/from_vscode").lazy_load()
end

vim.opt.completeopt = "menu,menuone,noselect"

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
-- Default dictionary setup (empty)
if dict_status then
  dict.setup({ dic = { ["*"] = {} } })

  local function setup_dictionary()
    local cwd = vim.fn.getcwd()
    if cwd:find("/oreade_cafe/mobile%-app", 1, true) then
      -- get all JSON files under assets/locales/**
      local files = vim.fn.glob(cwd .. "/assets/locales/**/*.json", true, true)
      -- make sure we actually found some files
      if #files > 0 then
        dict.setup({ dic = { ["*"] = files } })
      else
        dict.setup({ dic = { ["*"] = {} } })
        vim.notify("cmp-dictionary: no JSON files found in assets/locales", vim.log.levels.WARN)
      end
    else
      dict.setup({ dic = { ["*"] = {} } })
    end
  end

  -- run once
  setup_dictionary()

  -- re-run on directory change
  vim.api.nvim_create_autocmd("DirChanged", {
    callback = setup_dictionary,
  })
end
-- Single setup call for nvim-cmp
cmp.setup({
  -- Snippet configuration (requires luasnip)
  snippet = {
    expand = function(args)
      if luasnip then
        luasnip.lsp_expand(args.body)
      else
        vim.api.nvim_err_writeln("luasnip is not available for snippet expansion.")
      end
    end,
  },

  -- Key mappings
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
    ["<M-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion (Option + k on Mac)
    ["<M-j>"] = cmp.mapping.select_next_item(), -- Next suggestion (Option + j on Mac)
    -- Note: <Fn-k> and <Fn-j> might not be standard/reliable terminal codes
    -- ["<Fn-k>"] = cmp.mapping.select_prev_item(),
    -- ["<Fn-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),            -- Show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion

    -- Custom Tab mapping
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        -- elseif luasnip and luasnip.expandable() then -- Uncomment if you want Tab to expand snippets
        --  luasnip.expand()
        -- elseif luasnip and luasnip.expand_or_jumpable() then -- Uncomment if you want Tab to jump through snippet placeholders
        --  luasnip.expand_or_jump()
      elseif has_words_before() then
        -- If you want Tab to trigger completion when menu is not visible
        -- cmp.complete()
        -- Or just fallback to normal Tab behavior (indentation, etc.)
        fallback()
      else
        fallback()
      end
    end),
    -- You might need a Shift-Tab mapping as well if you customize Tab heavily
    -- ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    --  -- elseif luasnip and luasnip.jumpable(-1) then -- Uncomment for snippet jumping
    --  --   luasnip.jump(-1)
    --  else
    --    fallback()
    --  end
    -- end),
  }),
  -- Completion sources with priority
  sources = cmp.config.sources({
    { name = "nvim_lsp",        group_index = 2 },
    { name = "luasnip",         group_index = 1 },
    { name = "buffer",          group_index = 4 },
    { name = "path",            group_index = 4 },
    { name = "render-markdown", group_index = 4 },
    { name = "copilot",         group_index = 3 }, -- Lower priority
    { name = "dictionary",      keyword_length = 2, group_index = 5 },
    -- You might want to add 'nvim_lua' or 'cmdline' sources if needed
  }),

  -- Window appearance
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- Formatting (requires lspkind)
  formatting = {
    format = lspkind_status and lspkind.cmp_format({ -- Only use lspkind if loaded
      maxwidth = 50,
      ellipsis_char = "...",
      -- You can add mode = 'symbol_text' or 'text_symbol' etc. if desired
      -- mode = "symbol_text",
      -- Optional: Show source name in completion menu
      -- before = function (entry, vim_item)
      --   vim_item.menu = "["..string.upper(entry.source.name).."]"
      --   return vim_item
      -- end
    }) or nil, -- Fallback to default format if lspkind is missing
  },
})
