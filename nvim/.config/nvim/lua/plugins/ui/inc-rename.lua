return {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  config = function()
    require("inc_rename").setup({})
    vim.keymap.set("n", "<leader>er", ":IncRename ", { desc = "IncRename" })
  end,
}
