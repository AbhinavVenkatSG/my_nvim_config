return {
  "tpope/vim-dispatch",
  cmd = { "Dispatch", "Make", "Copen" },
  keys = {
    { "<Leader>mk", ":Make<CR>", desc = "Run make" },
    { "<Leader>dp", ":Dispatch<CR>", desc = "Run dispatch" },
  },
}
