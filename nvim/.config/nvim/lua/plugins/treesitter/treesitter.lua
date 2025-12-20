return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      modules = {},
      ensure_installed = {},
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enable = true },
      incremental_selection = { enable = false },
      -- incremental_selection = { -- TODO: review keys
      --   enable = true,
      --   keymaps = {
      --     init_selection = "gnn",
      --     node_incremental = "grn",
      --     scope_incremental = "grc",
      --     node_decremental = "grm",
      --   },
      -- },
      textobjects = { enable = true },
      indent = { enable = true }, -- TODO: see how it works?
    })
  end,
}
