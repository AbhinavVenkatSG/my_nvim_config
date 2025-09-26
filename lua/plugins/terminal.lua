return{
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- always use latest version
    config = function()
      require("toggleterm").setup({
        -- ⚙️ Basic settings
        size = 15,
        open_mapping = [[<C-\>]],
        shade_terminals = true,
        direction = "horizontal", -- default: horizontal, can also be 'vertical' or 'float'
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell, -- use the shell set in your system
      })

      --this is an example 



      -- 🪟 Optional: keymaps for different terminal modes
      local Terminal = require("toggleterm.terminal").Terminal

      -- Floating terminal
      local float_term = Terminal:new({ direction = "float", hidden = true })
      vim.keymap.set("n", "<leader>tf", function()
        float_term:toggle()
      end, { desc = "Toggle floating terminal" })

      -- Vertical terminal
      local vert_term = Terminal:new({ direction = "vertical", hidden = true })
      vim.keymap.set("n", "<leader>tv", function()
        vert_term:toggle()
      end, { desc = "Toggle vertical terminal" })

      -- Horizontal terminal
      local hori_term = Terminal:new({ direction = "horizontal", hidden = true })
      vim.keymap.set("n", "<leader>th", function()
        hori_term:toggle()
      end, { desc = "Toggle horizontal terminal" })
    end,
  }


}

