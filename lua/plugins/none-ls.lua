-- Install mason.nvim and mason-lspconfig
return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "nvimtools/none-ls.nvim",  -- For null-ls integration
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local null_ls = require("null-ls")

    -- Setup Mason to automatically install required tools
    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { "clangd", "gopls", "omnisharp", "pyright", "rust-analyzer", "lua_ls" }
    })

    -- Setup null-ls to use the installed tools (linters and formatters)
    null_ls.setup({
      sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.pyright,

        -- Go
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.diagnostics.golangci_lint,

        -- C/C++
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.clang_tidy,

        -- C#
        null_ls.builtins.formatting.dotnet_format,

        -- Lua
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.luacheck,

        -- Rust
        null_ls.builtins.diagnostics.rust_analyzer,
      },
    })

    -- Keybindings for formatting and diagnostics
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format Code" })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  end,
} 
