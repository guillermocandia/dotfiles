return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    position = "right",
  },
  config = function()
    require("trouble").setup({
      position = "right",
    })
    vim.keymap.set("n", "<leader>tt", function()
      require("trouble").toggle()
    end, { desc = "Trouble" })
    vim.keymap.set("n", "<leader>tw", function()
      require("trouble").toggle("workspace_diagnostics")
    end, { desc = "Trouble workspace" })
    vim.keymap.set("n", "<leader>tq", function()
      require("trouble").toggle("quickfix")
    end, { desc = "Trouble quickfix" })
    vim.keymap.set("n", "tr", function()
      require("trouble").toggle("lsp_references")
    end, { desc = "Trouble lsp_references" })
    vim.keymap.set("n", "<leader>ts", function()
      require("trouble").toggle("symbols")
    end, { desc = "Trouble symbols" })
    vim.keymap.set({ "n", "v", "i" }, "<C-d>", function()
      require("trouble").toggle("diagnostics")
    end, { desc = "Trouble diagnostics" })
  end,
}
