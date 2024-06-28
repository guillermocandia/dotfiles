return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      modules = {},
      ensure_installed = "all",
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
