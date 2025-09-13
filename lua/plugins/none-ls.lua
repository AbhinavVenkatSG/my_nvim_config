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
        ensure_installed = { "clangd", "gopls", "omnisharp", "pyright", "rust-analyzer", "lua_ls" },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.pyright,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.clang_tidy,
          null_ls.builtins.formatting.dotnet_format,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.rust_analyzer,
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format Code" })
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
    end,
  },
}
 
