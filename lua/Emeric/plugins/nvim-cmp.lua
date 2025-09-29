return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-dictionary",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local dict = require("cmp-dictionary")

    require("luasnip/loaders/from_vscode").lazy_load()

    vim.opt.completeopt = "menu,menuone,noselect"

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    dict.setup({ dic = { ["*"] = {} } })

    local function setup_dictionary()
      local cwd = vim.fn.getcwd()
      if cwd:find("/oreade_cafe/mobile%-app", 1, true) then
        local files = vim.fn.glob(cwd .. "/assets/locales/**/*.json", true, true)
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

    setup_dictionary()

    vim.api.nvim_create_autocmd("DirChanged", {
      callback = setup_dictionary,
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<M-k>"] = cmp.mapping.select_prev_item(),
        ["<M-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif has_words_before() then
            fallback()
          else
            fallback()
          end
        end),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp",        group_index = 2 },
        { name = "luasnip",         group_index = 1 },
        { name = "buffer",          group_index = 4 },
        { name = "path",            group_index = 4 },
        { name = "render-markdown", group_index = 4 },
        { name = "copilot",         group_index = 3 },
        { name = "dictionary",      keyword_length = 2, group_index = 5 },
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
  end,
}
