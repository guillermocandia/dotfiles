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
    local labels = {
      { "<leader>b", group = "BufferLine" },
      { "<leader>bc", group = "BufferLineClose" },
      { "<leader>d", group = "Debugger" },
      { "<leader>dp", group = "Python" },
      { "<leader>e", group = "ETC" },
      { "<leader>f", group = "Telescope" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Haskell tools" },
      { "<leader>l", group = "LSP" },
      { "<leader>n", group = "Noice" },
      { "<leader>t", group = "Trouble" },
      { "<leader>s", group = "Grug-far" },
    }
    wk.add(labels)
  end,
}
