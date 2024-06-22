vim.g.mapleader = ","

vim.keymap.set("n", "<leader>n", ":bn<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "<leader>x", ":bx<cr>", { desc = "Buffer close" })
