return {
  {
    "nvim-treesitter/nvim-treesitter",    -- Treesitter plugin
    build = ":TSUpdate",                  -- This will run `TSUpdate` to update parsers
    config = function()
      -- Setup Treesitter with your languages and features
      require("nvim-treesitter.configs").setup({
        auto_intall=true,
        highlight = { enable = true },    -- Enable syntax highlighting
        indent = { enable = true },       -- Enable indentation
        auto_install = true,              -- Automatically install missing parsers
      })
    end,
  }
}

