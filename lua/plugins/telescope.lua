return {
  -- Telescope plugin configuration
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Telescope key mappings
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end
  },

  -- Telescope UI Select extension
  {
    "nvim-telescope/telescope-ui-select.nvim",  -- The extension for ui-select
    config = function()
      -- Setup telescope with ui-select extension
      require("telescope").setup{
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- You can add more specific options here
              -- Example:
              -- width = 0.5,
              -- previewer = false,
            })
          }
        }
      }

      -- Load the ui-select extension
      require("telescope").load_extension("ui-select")
    end
  },
}

