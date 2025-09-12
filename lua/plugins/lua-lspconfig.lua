return {
  -- Mason and LSP Configurations
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "nvimtools/none-ls.nvim",  -- For null-ls integration
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local null_ls = require("null-ls")
    
    -- Setup Mason to install external tools automatically
    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { 
        "clangd",   -- C/C++
        "gopls",    -- Go
        "omnisharp", -- C#
        "pyright",  -- Python
        "rust-analyzer",  -- Rust
        "lua_ls"    -- Lua
      },
    })

    -- Setup null-ls for linters and formatters
    null_ls.setup({
      sources = {
        -- Python
        null_ls.builtins.formatting.black,        -- Black for Python formatting
        null_ls.builtins.formatting.isort,        -- Isort for Python imports sorting
        null_ls.builtins.diagnostics.pyright,    -- Pyright for Python diagnostics

        -- Go
        null_ls.builtins.formatting.gofmt,        -- GoFmt for Go formatting
        null_ls.builtins.diagnostics.golangci_lint, -- GolangCI-Lint for Go diagnostics

        -- C/C++
        null_ls.builtins.formatting.clang_format,  -- Clang-Format for C/C++ formatting
        null_ls.builtins.diagnostics.clang_tidy,   -- Clang-Tidy for C/C++ diagnostics

        -- C#
        null_ls.builtins.formatting.dotnet_format, -- .NET Format for C# formatting

        -- Lua
        null_ls.builtins.formatting.stylua,       -- Stylua for Lua formatting
        null_ls.builtins.diagnostics.luacheck,    -- Luacheck for Lua diagnostics

        -- Rust
        null_ls.builtins.diagnostics.rust_analyzer, -- Rust Analyzer for Rust diagnostics
      },
    })

    -- Keybindings for formatting and diagnostics
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format Code" })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  end,
}

