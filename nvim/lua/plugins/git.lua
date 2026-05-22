return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<Leader>gs", ":Git status<CR>", desc = "Git status" },
      { "<Leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<Leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
      { "<Leader>gb", ":Git blame<CR>", desc = "Git blame" },
      { "<Leader>gl", ":Git log<CR>",  desc = "Git log" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
}
