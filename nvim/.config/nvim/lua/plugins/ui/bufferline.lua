return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
      options = {
        numbers = "ordinal",
        indicator = {
          icon = " ",
        },
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
    config = function(_, opts)
      local bf = require("bufferline")
      bf.setup(opts)
      vim.keymap.set({ "n", "v" }, "<leader>bcr", ":BufferLineCloseRight <cr>", { desc = "BufferLineCloseRight" })
      vim.keymap.set({ "n", "v" }, "<leader>bcl", ":BufferLineCloseLeft <cr>", { desc = "BufferLineCloseLeft" })
      vim.keymap.set({ "n", "v" }, "<leader>bco", ":BufferLineCloseOthers <cr>", { desc = "BufferLineCloseOthers" })
      vim.keymap.set({ "n", "v" }, "<leader>bp", ":BufferLineTogglePin <cr>", { desc = "BufferLineTogglePin" })

      for i = 1, 9 do
        vim.keymap.set({ "n", "v" }, "<leader>" .. i, function()
          bf.go_to(i, true)
        end, { desc = "BufferLine go to " .. i })
      end
    end,
  },
}
