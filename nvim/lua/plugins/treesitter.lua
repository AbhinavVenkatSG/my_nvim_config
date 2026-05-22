return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "python", "rust", "go",
        "html", "css", "json", "yaml", "markdown",
      },
      auto_install = true,
      highlight = { enable = true },
      indent    = { enable = true },
    })

    -- ==========================================================================
    --  TREESITTER KEYBINDS  (commands, not normal-mode mappings)
    -- ==========================================================================

    -- --- Commands (run in command mode  : ):
    --   :TSInstall {lang}       install parser for language (e.g. :TSInstall python)
    --   :TSInstallInfo          list all available & installed parsers
    --   :TSUninstall {lang}     remove a parser
    --   :TSUpdate               update all installed parsers
    --   :TSUpdate {lang}        update specific parser
    --   :TSBufEnable highlight  enable  treesitter highlight in current buffer
    --   :TSBufDisable highlight disable treesitter highlight
    --   :TSBufToggle highlight  toggle  treesitter highlight
    --
    -- --- Config-based  (no manual keymaps needed for basic usage):
    --   highlight.enable = true   →  automatic syntax highlighting
    --   indent.enable    = true   →  smarter indentation based on AST
    --
    -- --- With nvim-treesitter-textobjects (optional add-on):
    --   ]m / [m            next / previous function start
    --   ]M / [M            next / previous function end
    --   ]i / [i            next / previous conditional
    --   af / if            around / inside a function
    --   ac / ic            around / inside a class
    --   al / il            around / inside a loop
    --   a: / i:            around / inside a conditional
    --   ]a / [a            next / previous argument
    --
  end,
}
