return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signcolumn = true,
      numhl = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 0,
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>gb", ":Gitsigns blame<cr>", { desc = "Blame" })
    vim.keymap.set({ "n", "v" }, "<leader>gd", ":Gitsigns diffthis<cr>", { desc = "Diff" })
  end,
}
