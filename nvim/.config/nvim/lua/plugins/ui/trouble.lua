return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        warn_no_results = false,
        open_no_results = true,
      })
      vim.keymap.set(
        { "n", "v", "i" },
        "<C-d>",
        ":Trouble diagnostics toggle<cr>",
        { desc = "Trouble diagnostics", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ts",
        ":Trouble symbols toggle focus=false<cr>",
        { desc = "Trouble symbols", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>tl",
        ":Trouble lsp toggle focus=false win.position=right<cr>",
        { desc = "Trouble lsp", silent = true }
      )
      vim.keymap.set("n", "<leader>tq", ":Trouble quickfix toggle<cr>", { desc = "Trouble quickfix", silent = true })
      vim.keymap.set("n", "<leader>tL", ":Trouble locllist toggle<cr>", { desc = "Trouble loclist", silent = true })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    config = function()
      local todo = require("todo-comments")
      todo.setup()
      vim.keymap.set("n", "<leader>tt", ":Trouble todo<cr>", { desc = "Trouble todo", silent = true })
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "Telescope todo", silent = true })
    end,
  },
}
