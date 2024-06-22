return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find_files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live_grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help_tags" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Telescope commands" })
      vim.keymap.set("n", "<leader>fu", builtin.builtin, { desc = "Telescope builtin" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })
      vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Telescope registers" })
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    "ghassan0/telescope-glyph.nvim",
    config = function()
      require("telescope").load_extension("glyph")
    end,
  },
}
