return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local noice = require("noice")
    noice.setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          view = "mini",
        },
      },
      cmdline = {
        view = "cmdline_popup",
        format = {
          conceal = false,
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = -3,
            col = "50%",
          },
          size = {
            width = 120,
            height = "auto",
          },
          border = {
            style = "none",
            padding = { 1, 3 },
          },
          win_options = {
            winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
          },
        },
        popupmenu = {
          position = {
            row = -5,
            col = "50%",
          },
          size = {
            width = 120,
            height = "auto",
          },
          border = {
            style = "none",
            padding = { 1, 3 },
          },
          win_options = {
            winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
          },
        },
      },
    })

    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set("n", "<leader>nh", function()
      noice.cmd("history")
    end, { desc = "History" })

    vim.keymap.set("n", "<leader>nl", function()
      noice.cmd("last")
    end, { desc = "Last" })

    vim.keymap.set("n", "<leader>ns", function()
      noice.cmd("stats")
    end, { desc = "Stats" })

    vim.keymap.set("n", "<leader>ne", function()
      noice.cmd("errors")
    end, { desc = "Errors" })

    vim.keymap.set("n", "<leader>nd", function()
      noice.cmd("dismiss")
    end, { desc = "Dismiss" })

    vim.keymap.set("n", "<leader>nt", function()
      noice.cmd("telescope")
    end, { desc = "Telescope" })
  end,
}
