return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  ft = "python",
  keys = {
    { "<leader>vv", "<cmd>VenvSelect<cr>", desc = "Select Python Virtual Env" },
    { "<leader>vr", "<cmd>VenvSelectCached<cr>", desc = "Reactivate Last Venv" },
  },
  opts = {
    -- Auto-activate when entering a Python project
    automatic_activation = {
      enabled = true,
      reload_on_activate = true,
    },
    -- Search for venv in these locations
    search = true,
    search_venv_managers = {
      "poetry",    -- Poetry
      "pipenv",     -- Pipenv
      "pdm",       -- PDM
      "uv",        -- UV
      "rye",       -- Rye
      "hatch",     -- Hatch
    },
  },
}
