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
      sources = {
        "filesystem",
      },
      default_component_configs = {
        modified = {
          symbol = "",
        },
        name = {
          trailing_slash = true,
          highlight_opened_files = true,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
      },
      window = {
        width = 46,
      },
    })
    vim.keymap.set({ "n", "v" }, "<C-n>", ":Neotree filesystem left toggle<cr>", { desc = "Neotree toogle" })
    vim.keymap.set({ "n", "v" }, "<C-m>", ":Neotree filesystem current toggle<cr>", { desc = "Neotree current" })
    vim.keymap.set({ "n", "v" }, "<C-,>", ":Neotree filesystem left reveal<cr>", { desc = "Neotree file" })
  end,
}
