return {
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set("n", "<leader>em", ":MarkdownPreviewToggle<cr>", { desc = "MarkdownPreviewToggle" })
    end,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local otter = require("otter")
      otter.setup({
        lsp = {
          diagnostic_update_events = { "InsertLeave", "BufWritePost" },
        },
      })

      local languages = nil
      local completion = true
      local diagnostics = true
      local tsquery = nil

      vim.api.nvim_create_autocmd({ "BufEnter", "BufHidden" }, {
        pattern = { "*.md" },
        callback = function(ev)
          if ev.event == "BufEnter" then
            otter.activate(languages, completion, diagnostics, tsquery)
            return
          end
          otter.deactivate(completion, diagnostics)
        end,
      })
    end,
  },
}
