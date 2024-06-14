return {
  "danymat/neogen",
  config = function()
    local neogen = require("neogen")
    neogen.setup({
      input_after_comment = false,
      snippet_engine = "luasnip",
    })
    vim.keymap.set("n", "<leader>nn", neogen.generate, { desc = "Neogen generate" })
  end,
}
