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
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
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
          -- doesnt work
          -- custom_areas = {
          --   left = function()
          --     return {
          --       result = {
          --         text = "test",
          --         fg = "white",
          --       },
          --     }
          --   end,
          --   right = function()
          --     local result = {}
          --     local seve = vim.diagnostic.severity
          --     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
          --     local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
          --     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
          --     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
          --
          --     if error ~= 0 then
          --       table.insert(result, { text = "  " .. error, fg = "#EC5241" })
          --     end
          --
          --     if warning ~= 0 then
          --       table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
          --     end
          --
          --     if hint ~= 0 then
          --       table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
          --     end
          --
          --     if info ~= 0 then
          --       table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
          --     end
          --     return result
          --   end,
          -- },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>bcr", ":BufferLineCloseRight<cr>", { desc = "BufferLineCloseRight" })
      vim.keymap.set({ "n", "v" }, "<leader>bcl", ":BufferLineCloseLeft<cr>", { desc = "BufferLineCloseLeft" })
      vim.keymap.set({ "n", "v" }, "<leader>bco", ":BufferLineCloseOthers<cr>", { desc = "BufferLineCloseOthers" })
      vim.keymap.set({ "n", "v" }, "<leader>bt", ":BufferLineTogglePin<cr>", { desc = "BufferLineTogglePin" })

      for i = 1, 9 do
        vim.keymap.set({ "n", "v" }, "<leader>" .. i, function()
          bf.go_to(i, true)
        end, { desc = "Go to buffer " .. i })
      end
    end,
  },
}
