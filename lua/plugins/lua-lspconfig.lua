return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",      -- Lua
          "denols",      -- Deno JS/TS
          "clangd",      -- C, C++
          "gopls",       -- Go
          "omnisharp",   -- C# / .NET
          "pyright",     -- Python 🐍
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Deno
      vim.lsp.config("denols", {
        root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" }),
      })

      -- C / C++
      vim.lsp.config("clangd", {})

      -- Go
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              unreachable = true,
            },
          },
        },
      })

      -- C# / .NET
      vim.lsp.config("omnisharp", {
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
      })

      -- Python 🐍
      vim.lsp.config("pyright", {
        -- Optional: you can add type checking config here
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- or "strict"
            },
          },
        },
      })

      -- Enable all servers
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("denols")
      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")
      vim.lsp.enable("omnisharp")
      vim.lsp.enable("pyright")

      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Docs", silent = true })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition", silent = true })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action", silent = true })
    end,
  },
}

