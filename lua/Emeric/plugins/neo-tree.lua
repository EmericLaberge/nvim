return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "antosha417/nvim-lsp-file-operations",
  },
  branch = "main",
  lazy = false,
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "NC",
      enable_git_status = true,
      enable_diagnostics = true,
      enable_modified_markers = true,
      enable_opened_markers = true,
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
      sort_case_insensitive = true,

      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },

      source_selector = {
        winbar = true,
        statusline = false,
        content_layout = "center",
        tabs_layout = "equal",
        show_separator_on_edge = true,
        separator = { left = "▏", right = "▕" },
        sources = {
          { source = "filesystem",       display_name = "  Files " },
          { source = "buffers",          display_name = "  Buffers " },
          { source = "git_status",       display_name = "  Git " },
          { source = "document_symbols", display_name = "  Symbols " },
        },
      },

      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = nil,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "📁",
          folder_open = "📂",
          folder_empty = "📁",
          folder_empty_open = "📂",
          default = "*",
          highlight = "NeoTreeFileIcon",
          provider = function(icon, node, state)
            if node.type == "file" or node.type == "terminal" then
              local ok, web_devicons = pcall(require, "nvim-web-devicons")
              if ok then
                local name = node.type == "terminal" and "terminal" or node.name
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },

      window = {
        position = "left",
        width = 35,
        auto_expand_width = false,
        mappings = {
          ["l"]       = "open",
          ["h"]       = "close_node",
          ["<CR>"]    = "open",
          ["<C-e>"]   = "open",
          ["v"]       = "open_vsplit",
          ["s"]       = "open_split",
          ["t"]       = "open_tabnew",
          ["<C-t>"]   = "open_tabnew",
          ["a"]       = { "add", config = { show_path = "relative" } },
          ["A"]       = "add_directory",
          ["d"]       = "delete",
          ["T"]       = "trash",
          ["u"]       = "undo",
          ["U"]       = "restore_from_trash",
          ["r"]       = "rename",
          ["y"]       = "copy_to_clipboard",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
          ["c"]       = "copy",
          ["m"]       = "move",
          ["q"]       = "close_window",
          ["R"]       = "refresh",
          ["<C-r>"]   = "clear_clipboard",
          ["z"]       = "close_all_nodes",
          ["<Tab>"]   = { "toggle_node", nowait = false },
          ["<"]       = "prev_source",
          [">"]       = "next_source",
          ["P"]       = {
            "toggle_preview",
            config = {
              use_float = true,
              use_snacks_image = true,
              use_image_nvim = true,
            },
          },
          ["<C-f>"]   = { "scroll_preview", config = { direction = -10 } },
          ["<C-b>"]   = { "scroll_preview", config = { direction = 10 } },
          ["Y"]       = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "l")
              vim.notify("Copied: " .. path)
            end,
            desc = "Copy Path to Clipboard",
          },
          ["?"]       = "show_help",
        },
        fuzzy_finder_mappings = {
          ["<C-n>"]   = "move_cursor_down",
          ["<C-p>"]   = "move_cursor_up",
          ["<Esc>"]   = "close",
        },
      },

      filesystem = {
        window = {
          mappings = {
            ["H"]       = "toggle_hidden",
            ["I"]       = "toggle_hidden",
            ["/"]       = "fuzzy_finder",
            ["f"]       = "filter_on_submit",
            ["F"]       = "clear_filter",
            ["<BS>"]    = "navigate_up",
            ["."]       = "set_root",
            ["[g"]      = "prev_git_modified",
            ["]g"]      = "next_git_modified",
            ["i"]       = "show_file_details",
            ["b"]       = "rename_basename",
            ["o"]       = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["oc"]      = { "order_by_created", nowait = false },
            ["od"]      = { "order_by_diagnostics", nowait = false },
            ["og"]      = { "order_by_git_status", nowait = false },
            ["om"]      = { "order_by_modified", nowait = false },
            ["on"]      = { "order_by_name", nowait = false },
            ["os"]      = { "order_by_size", nowait = false },
            ["ot"]      = { "order_by_type", nowait = false },
          },
          fuzzy_finder_mappings = {
            ["<C-n>"]   = "move_cursor_down",
            ["<C-p>"]   = "move_cursor_up",
            ["<Esc>"]   = "close",
          },
        },
        hijack_netrw_behavior = "open_default",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        async_directory_scan = "auto",
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            "node_modules",
            ".git",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        search_limit = 50,
      },

      buffers = {
        show_unloaded = true,
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
      },

      git_status = {
        window = {
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },

      document_symbols = {
        follow_cursor = true,
        client_filters = "first",
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Module = { icon = "", hl = "Exception" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Method = { icon = "󰊕", hl = "Function" },
          Property = { icon = "󰆧", hl = "@property" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "󰒻", hl = "@number" },
          Interface = { icon = "", hl = "Type" },
          Function = { icon = "󰊕", hl = "Function" },
          Variable = { icon = "", hl = "@variable" },
          Constant = { icon = "", hl = "Constant" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Boolean = { icon = "", hl = "Boolean" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Struct = { icon = "󰌗", hl = "Type" },
          Event = { icon = "", hl = "Constant" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
        },
      },
    })

    -- LSP file operations: notify LSP on rename/delete/move
    require("lsp-file-operations").setup()

    -- Global keymaps (outside neo-tree window)
    vim.keymap.set("n", "<leader>tt", ":Neotree toggle<CR>",   { desc = "Toggle File Tree" })
    vim.keymap.set("n", "<leader>tf", ":Neotree focus<CR>",    { desc = "Focus File Tree" })
    vim.keymap.set("n", "<leader>ts", ":Neotree reveal<CR>",   { desc = "Reveal Current File" })
    vim.keymap.set("n", "<leader>tc", ":Neotree collapse<CR>", { desc = "Collapse Tree" })
  end,
}
