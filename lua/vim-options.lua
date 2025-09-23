vim.env.CC = "clang"
vim.env.CXX = "clang++"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2


vim.opt.number = true
vim.opt.relativenumber = true


vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Vertical terminal" })
vim.keymap.set("n", "<leader>th", ":split | terminal<CR>", { desc = "Horizontal terminal" })

