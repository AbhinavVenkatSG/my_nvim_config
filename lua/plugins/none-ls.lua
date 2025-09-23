return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JS/TS/HTML/CSS/JSON
        null_ls.builtins.formatting.prettier,
        require("none-ls.diagnostics.eslint"),

        -- Python
        null_ls.builtins.formatting.black,
        --null_ls.builtins.formatting.isort,

        -- Go
        null_ls.builtins.formatting.goimports,

        -- C/C++
        null_ls.builtins.formatting.clang_format,
      },
    })

    -- Keymap to format current file with LSP/null-ls
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format current buffer" })
  end,
}

