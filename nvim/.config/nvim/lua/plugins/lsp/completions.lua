return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "mrcjkb/haskell-snippets.nvim",
    },
    build = "make install_jsregexp",
    config = function()
      local luasnip = require("luasnip")
      luasnip.setup()

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("python", { "django" })

      local haskell_snippets = require("haskell-snippets").all
      luasnip.add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            local lspserver_name = nil
            pcall(function()
              lspserver_name = entry.source.source.client.name
              vim_item.menu = " " .. vim_item.menu .. " | " .. lspserver_name
            end)
            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "lazydev" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
