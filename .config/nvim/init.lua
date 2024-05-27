Lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(Lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    Lazypath,
  })
end
vim.opt.rtp:prepend(Lazypath)

require("vim-options")
require("lazy").setup("plugins")

vim.cmd.colorscheme("catppuccin")
