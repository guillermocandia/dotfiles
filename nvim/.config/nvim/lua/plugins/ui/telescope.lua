return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
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
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope oldfiles" })

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

  {
    "ziontee113/icon-picker.nvim",
    enabled = false,
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })

      vim.keymap.set(
        "n",
        "<leader>fp",
        ":IconPickerYank<cr>",
        { desc = "Icon picker yank", noremap = true, silent = true }
      )
      vim.keymap.set("i", "<C-i>", ":IconPickerInsert<cr>", { desc = "Icon picker", noremap = true, silent = true })
    end,
  },
}
