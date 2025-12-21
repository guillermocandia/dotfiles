return {
  "mistweaverco/bafa.nvim",
  config = function()
    vim.keymap.set({ "n", "v" }, "<C-l>", function()
      require("bafa.ui").toggle()
    end, { desc = "Bafa" })
  end,
}
