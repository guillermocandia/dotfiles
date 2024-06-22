return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      source_selector = {
        statusline = true,
      },
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
        use_libuv_file_watcher = true,
      },
    })
    vim.keymap.set({ "n", "v" }, "<C-n>", ":Neotree filesystem left toggle <cr>", { desc = "Neotree" })
  end,
}
