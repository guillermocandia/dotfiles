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
    vim.keymap.set("n", "<leader>xx", function()
      require("trouble").toggle()
    end, { desc = "Trouble" })
    vim.keymap.set("n", "<leader>xw", function()
      require("trouble").toggle("workspace_diagnostics")
    end, { desc = "Trouble workspace" })
    vim.keymap.set("n", "<leader>xd", function()
      require("trouble").toggle("document_diagnostics")
    end, { desc = "Trouble document" })
    vim.keymap.set("n", "<leader>xq", function()
      require("trouble").toggle("quickfix")
    end, { desc = "Trouble quickfix" })
    vim.keymap.set("n", "<leader>xl", function()
      require("trouble").toggle("loclist")
    end, { desc = "Trouble loclist" })
    vim.keymap.set("n", "gR", function()
      require("trouble").toggle("lsp_references")
    end, { desc = "Trouble lsp_references" })
    vim.keymap.set("n", "<leader>xs", function()
      require("trouble").toggle("symbols")
    end, { desc = "Trouble symbols" })
  end,
}
