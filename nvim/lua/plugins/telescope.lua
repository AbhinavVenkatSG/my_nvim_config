return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<Leader>ff", ":Telescope find_files<CR>", desc = "Find files" },
    { "<Leader>fg", ":Telescope live_grep<CR>",  desc = "Live grep" },
    { "<Leader>fb", ":Telescope buffers<CR>",    desc = "Buffers" },
    { "<Leader>fh", ":Telescope help_tags<CR>",  desc = "Help tags" },
    { "<Leader>fo", ":Telescope oldfiles<CR>",   desc = "Old files" },
    { "<Leader>fw", ":Telescope grep_string<CR>",desc = "Word under cursor" },
    { "<Leader>fd", ":Telescope diagnostics<CR>",desc = "Diagnostics" },
    { "<Leader>fr", ":Telescope registers<CR>",  desc = "Registers" },
  },
  config = function()
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and not parsers.ft_to_lang then
      parsers.ft_to_lang = function(ft)
        return vim.treesitter.language.get_lang(ft) or ft
      end
    end
    require("telescope").setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
    })
  end,
}
