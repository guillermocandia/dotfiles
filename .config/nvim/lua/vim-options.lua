vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = ","

vim.diagnostic.config({
  virtual_text = true,
  underline = false,
  update_in_insert = true,
})
