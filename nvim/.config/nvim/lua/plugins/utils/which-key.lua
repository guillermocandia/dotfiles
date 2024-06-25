return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 0
  end,
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.setup()
    local labels = require("plugins.utils.extra.which-key.labels")
    wk.register(labels)
  end,
}
