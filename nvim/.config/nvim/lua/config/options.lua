vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.listchars = "eol:󰌑"
vim.opt.list = true
vim.opt.cursorlineopt = "number"
vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.titlestring = "nvim"
vim.opt.title = true

vim.diagnostic.config({
  virtual_text = {
    virt_text_pos = "right_align",
    source = true,
  },
  underline = false,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
})
