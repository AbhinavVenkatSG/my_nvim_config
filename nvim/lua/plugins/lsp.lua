return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities()
    end

    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set({ "n", "x" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    end

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "eslint",
        "pyright",
        "gopls",
        "clangd",
        "rust_analyzer",
        "jdtls",
        "omnisharp",
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
      },
    })
  end,
}
