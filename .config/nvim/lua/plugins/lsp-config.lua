return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = {
        "bashls", -- bash
        -- "jedi_language_server", -- python
        -- "pyright", -- python
        "pylsp", -- python
      }
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      vim.keymap.set({ "n", "v" }, "<leader>lh", vim.lsp.buf.hover, { desc = "LSP hover" })
      vim.keymap.set({ "n", "v" }, "<leader>ld", vim.lsp.buf.definition, { desc = "LSP definition" })
      vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code_action" })
      vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "LSP format" })
    end,
  },
}
