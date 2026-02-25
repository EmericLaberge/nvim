return {
  "mrjones2014/legendary.nvim",
  event = "VeryLazy",
  dependencies = { "kkharji/sqlite.lua" },
  config = function()
    local legendary = require("legendary")

    legendary.setup({
      select_prompt = "󰆄 ",
      -- Use which_key and lazy_nvim extensions to auto-register keymaps and commands
      extensions = {
        which_key = { auto_register = true },
        lazy_nvim = { auto_register = true },
      },
    })

    -- Keymap principal pour ouvrir legendary
    vim.keymap.set("n", "<leader><leader>", function()
      require("legendary").find()
    end, { desc = "Legendary find keymaps/commands" })
  end,
}
