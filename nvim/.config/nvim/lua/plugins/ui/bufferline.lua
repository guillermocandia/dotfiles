return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local bf = require("bufferline")
      bf.setup({
        options = {
          numbers = "ordinal",
          indicator = {
            icon = "▐",
          },
          max_name_length = 25,
          max_prefix_length = 20,
          tab_size = 25,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, _, _, _)
            local c = math.min(10, count)
            local s = string.rep("!", c)
            if count > 10 then
              s = "¿? !!!!!!!!!!"
            end
            return " " .. s
          end,
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
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with({ icon = "󰐃" }),
            },
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>bcr", ":BufferLineCloseRight<cr>", { desc = "BufferLineCloseRight" })
      vim.keymap.set({ "n", "v" }, "<leader>bcl", ":BufferLineCloseLeft<cr>", { desc = "BufferLineCloseLeft" })
      vim.keymap.set({ "n", "v" }, "<leader>bco", ":BufferLineCloseOthers<cr>", { desc = "BufferLineCloseOthers" })
      vim.keymap.set({ "n", "v" }, "<leader>bt", ":BufferLineTogglePin<cr>", { desc = "BufferLineTogglePin" })

      for i = 1, 5 do
        vim.keymap.set({ "n", "v" }, "<leader>" .. i, function()
          bf.go_to(i, true)
        end, { desc = "Go to buffer " .. i })
      end
    end,
  },
}
