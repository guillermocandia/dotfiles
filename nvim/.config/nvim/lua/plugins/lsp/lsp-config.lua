return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      local lsp_servers = {
        "lua_ls", -- lua
        "bashls", -- bash
        -- "pyright", -- python
        "marksman", -- markdown
        "yamlls", -- yaml
        "jsonls", -- json
        "tombi", -- toml
        "ruff", -- python
      }

      mason_lspconfig.setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
        automatic_enable = false,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, lsp in ipairs(lsp_servers) do
        vim.lsp.config(lsp, {
          capabilities = capabilities,
        })
        vim.lsp.enable(lsp)
      end

      local opts = { noremap = true, silent = true }
      opts.desc = "LSP hover"
      vim.keymap.set({ "n", "v" }, "<leader>lh", vim.lsp.buf.hover, opts)
      opts.desc = "LSP definition"
      vim.keymap.set({ "n", "v" }, "<leader>ld", vim.lsp.buf.definition, opts)
      opts.desc = "LSP declaration"
      vim.keymap.set({ "n", "v" }, "<leader>fD", vim.lsp.buf.declaration, opts)
      opts.desc = "LSP code action"
      vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
      opts.desc = "LSP format"
      vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, opts)
      opts.desc = "LSP rename"
      vim.keymap.set({ "n", "v" }, "<leader>lr", vim.lsp.buf.rename, opts)
    end,
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
      require("null-ls").setup({
        sources = {}, -- tools not supported by mason
      })
      require("mason-null-ls").setup({
        ensure_installed = {
          "luacheck", -- lua linter
          "stylua", -- lua formatter
          -- "black", -- python formatter
          -- "isort", -- python formatter
          "shfmt", -- bash formatter
          "markdownlint-cli2", -- markdown linter, formatter
          "yamlfmt", -- yaml formatter
        },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
}
