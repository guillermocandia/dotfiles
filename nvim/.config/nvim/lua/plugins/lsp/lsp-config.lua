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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })

      -- use none-ls for formatting
      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end

      -- lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      local servers = {
        "bashls", -- bash
        "pylsp", -- python
        "marksman", -- markdown
        "yamlls", -- yaml
        "jsonls", -- json
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
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
      vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, opts)

      local builtin = require("telescope.builtin")
      opts.desc = "LSP references"
      vim.keymap.set({ "n", "v" }, "<leader>lR", builtin.lsp_references, opts)
      opts.desc = "LSP implementations"
      vim.keymap.set({ "n", "v" }, "<leader>li", builtin.lsp_implementations, opts)
    end,
  },
}
