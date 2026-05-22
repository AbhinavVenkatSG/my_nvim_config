return {
  "tpope/vim-dadbod",
  cmd = { "DB", "DBUI" },
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
    },
  },
  keys = {
    { "<Leader>db", ":DBUI<CR>", desc = "Database UI" },
  },
}
