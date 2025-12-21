return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup()
    vim.keymap.set({ "n", "v" }, "<leader>ss", function()
      require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>"), transient = true } })
    end, { desc = "grug-far: Search current word" })

    vim.keymap.set({ "n", "v" }, "<leader>sf", function()
      require("grug-far").open({
        prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%"), transient = true },
      })
    end, { desc = "grug-far: Search current word in current file" })

    vim.keymap.set({ "v" }, "<leader>sv", function()
      require("grug-far").with_visual_selection({
        prefills = { paths = vim.fn.expand("%"), transient = true },
      })
    end, { desc = "grug-far: Search visual selection in current file" })

    vim.keymap.set({ "v" }, "<leader>si", function()
      require("grug-far").open({ visualSelectionUsage = "operate-within-range", transient = true })
    end, { desc = "grug-far: Search within range" })
  end,
}
