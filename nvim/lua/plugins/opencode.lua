return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  keys = {
    -- Press <Leader>oi to manually start your server in a right-side split
    { "<Leader>oi", function()
        Snacks.terminal("opencode --port 8000", {
          win = { position = "right", width = math.floor(vim.o.columns * 0.35) }
        })
      end, desc = "Init opencode server", mode = "n" },

    { "<Leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask opencode…", mode = { "n", "x" } },
    { "<Leader>os", function() require("opencode").select() end, desc = "Select opencode…", mode = { "n", "x" } },
    { "<Leader>ot", function() require("opencode").toggle() end, desc = "Toggle opencode", mode = { "n", "t" } },
    { "go", function() return require("opencode").operator("@this ") end, desc = "Add range to opencode", expr = true, mode = { "n", "x" } },
    { "goo", function() return require("opencode").operator("@this ") .. " _" end, desc = "Add line to opencode", expr = true, mode = "n" },
    { "<S-C-u>", function() require("opencode").command("session.half.page.up") end, desc = "Scroll opencode up", mode = "n" },
    { "<S-C-d>", function() require("opencode").command("session.half.page.down") end, desc = "Scroll opencode down", mode = "n" },
  },
  
  -- NEW: `init` runs BEFORE the plugin loads, so `opencode` will actually see this config!
  init = function()
    vim.g.opencode_opts = {
      server = {
        url = "http://localhost:8000",
      },
      ask = {
        snacks = {
          icon = "󰚩 ",
          win = { border = "rounded" },
        },
      },
      select = {
        snacks = {
          layout = { preset = "vscode" },
          win = { border = "rounded" },
        },
      },
    }
  end,
  
  -- `config` is kept strictly for variables that don't need to be set prior to load
  config = function()
    vim.o.autoread = true
  end,
}
