return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    local nhc = require("nvim-highlight-colors")
    nhc.setup({})
    vim.keymap.set({ "n", "v" }, "<leader>eh", nhc.toggle, { desc = "Highlight colors" })
  end,
}
