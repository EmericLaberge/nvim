return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  branch = "v3.x",
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = false,
      enable_diagnostics = false,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "overleaf",
      },
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem", display_name = " Files " },
          { source = "buffers", display_name = " Buffers " },
          { source = "git_status", display_name = " Git " },
          { source = "overleaf", display_name = " Overleaf " },
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = false,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
          highlight = "NeoTreeFileIcon",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = false,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            untracked = "",
            ignored = "",
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
        use_libuv_file_watcher = false,
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
        },
      },
      buffers = {
        show_unloaded = true,
      },
      overleaf = {},
      window = {
        width = 40,
        mappings = {
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "l")
              vim.notify("Copied: " .. path)
            end,
            desc = "Copy Path to Clipboard",
          },
          -- Overleaf-specific keymaps
          ["<cr>"] = "overleaf_open",
          ["a"] = "overleaf_new",
          ["A"] = "overleaf_new_dir",
          ["d"] = "overleaf_delete",
          ["r"] = "overleaf_rename",
          ["u"] = "overleaf_upload",
          ["R"] = {
            function(state)
              require("Emeric.neo-tree.overleaf-source").refresh(state)
            end,
            desc = "Refresh Overleaf",
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>ot", "<cmd>Neotree toggle overleaf<cr>", desc = "Overleaf Tree" },
  },
}
