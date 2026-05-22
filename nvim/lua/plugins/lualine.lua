return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local theme = "onedark"
    require("lualine").setup({
      options = { theme = theme },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })

    vim.keymap.set("n", "<Leader>th", function()
      local themes = { "onedark", "dracula", "tokyonight", "catppuccin", "industry" }
      local cur = require("lualine").get_config().options.theme
      local idx = 0
      for i, t in ipairs(themes) do
        if t == cur then
          idx = i
          break
        end
      end
      local next = themes[(idx % #themes) + 1]
      pcall(vim.cmd, "colorscheme " .. next)
      require("lualine").setup({ options = { theme = next } })
      vim.notify("Theme: " .. next)
    end, { desc = "Cycle theme" })
  end,
}
