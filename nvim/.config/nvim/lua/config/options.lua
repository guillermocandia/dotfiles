vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.termguicolors = true

vim.diagnostic.config({
  virtual_text = {
    virt_text_pos = "right_align",
    source = true,
  },
  underline = false,
  update_in_insert = true,
  signs = true,
})
