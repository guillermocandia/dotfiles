return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,  -- lua
        null_ls.builtins.formatting.shfmt,   -- bash
        null_ls.builtins.formatting.black,   -- python
        null_ls.builtins.formatting.isort,   -- python
        null_ls.builtins.diagnostics.pylint, -- python
        -- null_ls.builtins.completion.spell,   -- spell
      },
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
