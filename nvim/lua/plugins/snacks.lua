return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    bigfile = { enabled = true },
    indent  = { enabled = true },
    input   = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    terminal = { enabled = true },
    dashboard = { enabled = false },
    explorer  = { enabled = false },
    picker    = {
      enabled = true,
      actions = {
        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    },
    scratch   = { enabled = false },
    scroll    = { enabled = false },
    statuscolumn = { enabled = false },
    words     = { enabled = false },
    zen       = { enabled = false },
  },
  keys = {
    { "<Leader>t", function() Snacks.terminal.toggle() end, desc = "Toggle terminal" },
    { "<Leader>T", function() Snacks.terminal() end, desc = "New terminal" },
  },
}
