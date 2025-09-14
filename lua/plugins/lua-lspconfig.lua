return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",          -- C/C++
          "gopls",           -- Go
          "omnisharp",       -- C#
          "pyright",         -- Python
          "rust_analyzer",   -- Rust
          "lua_ls",          -- Lua
          "tsserver",        -- JavaScript/TypeScript
        },
      })

      local lspconfig = require("lspconfig")

      -- Setup each server
      local servers = {
        "clangd",
        "gopls",
        "omnisharp",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "tsserver",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end
    end,
  },
}

