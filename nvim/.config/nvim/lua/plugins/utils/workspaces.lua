return {
  "natecraddock/workspaces.nvim",
  config = function()
    require("workspaces").setup()
    local telescope = require("telescope")
    telescope.load_extension("workspaces")
    vim.keymap.set("n", "<leader>fw", ":Telescope workspaces<cr>", { desc = "Telescope workspaces" })
  end,
}
