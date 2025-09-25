
return {
  -- Mason for installing LSP servers
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
          "lua_ls",
          "denols",
          "clangd",
          "gopls",
          "omnisharp",
          "pyright",
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

      -- C/C++
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

      -- Python
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- or "strict"
            },
          },
        },
      })

      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Show diagnostics in float on CursorHold
      vim.o.updatetime = 250
      vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

      -- Keymaps for LSP and diagnostics
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Docs", silent = true })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition", silent = true })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action", silent = true })

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show Line Diagnostic" })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to LocList" })

      -- Enable all LSPs (assuming vim.lsp.enable is defined somewhere in your framework)
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("denols")
      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")
      vim.lsp.enable("omnisharp")
      vim.lsp.enable("pyright")
    end,
  },
}
