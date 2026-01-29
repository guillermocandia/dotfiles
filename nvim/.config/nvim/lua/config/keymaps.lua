vim.g.mapleader = ","
vim.g.maplocalleader = "."

vim.keymap.set("n", "<leader>bn", ":bn<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>bp", ":bp<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "<leader>bd", ":bd<cr>", { desc = "Buffer close" })
vim.keymap.set({ "n", "v" }, "<leader>nr", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative numbers" })
