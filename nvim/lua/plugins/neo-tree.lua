return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<Leader>N", ":Neotree toggle filesystem left<CR>", desc = "Toggle file explorer" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_diagnostics = false,
      enable_git_status = true,
      enable_modified_markers = true,
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = "   Files  " },
          { source = "buffers",    display_name = "   Buffers " },
          { source = "git_status", display_name = "  󰊢 Git  " },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            ".git",
          },
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        find_command = {
          "fd", "-H", "-E", ".git", "--type", "f", "--type", "l",
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
      git_status = {
        window = {
          position = "float",
        },
      },
      window = {
        position = "left",
        width = 34,
        mappings = {
          ["l"]  = "open",
          ["h"]  = "close_node",
          ["H"]  = "prev_source",
          ["<tab>"] = "toggle_preview",
          ["P"]  = { "toggle_preview", config = { use_float = true } },
          ["L"]  = "focus_preview",
          ["S"]  = "open_split",
          ["V"]  = "open_vsplit",
          ["t"]  = "open_tab_drop",
          ["w"]  = "open_with_window_picker",
          ["a"]  = "add",
          ["d"]  = "delete",
          ["r"]  = "rename",
          ["c"]  = "copy",
          ["m"]  = "move",
          ["y"]  = "copy_to_clipboard",
          ["x"]  = "cut_to_clipboard",
          ["p"]  = "paste_from_clipboard",
          ["R"]  = "refresh",
          ["?"]  = "show_help",
          ["<esc>"] = "revert_preview",
          ["q"]  = "close_window",
        },
      },
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open   = "",
          folder_empty  = "",
          default       = "",
        },
        git_status = {
          symbols = {
            added     = "",
            deleted   = "✖",
            modified  = "",
            renamed   = "",
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
        },
      },
    })

  end,
}
