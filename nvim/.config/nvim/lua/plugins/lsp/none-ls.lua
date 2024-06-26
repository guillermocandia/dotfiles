return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason").setup()
      local mason_null_ls = require("mason-null-ls")
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {},
      })
      mason_null_ls.setup({
        ensure_installed = {
          "luacheck", -- lua linter
          "stylua", -- lua formatter
          "pylint", -- python linter
          "black", -- python formatter
          "isort", -- python formatter
          "shfmt", -- bash formatter
          "markdownlint", -- markdown linter, formatter
        },
        automatic_installation = false,
        handlers = {},
      })
    end,
  },
}
