local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

opts.desc = "codelens"
vim.keymap.set("n", "<leader>hc", vim.lsp.codelens.run, opts)
opts.desc = "Hoogle search for the type signature of the definition under the cursor"
vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts)
opts.desc = "Evaluate all code snipes"
vim.keymap.set("n", "<leader>ha", ht.lsp.buf_eval_all, opts)
opts.desc = "Toggle a GHCi repl for the current package"
vim.keymap.set("n", "<leader>hp", ht.repl.toggle, opts)
opts.desc = "Toggle a GHCi repl for the current buffer"
vim.keymap.set("n", "<leader>hb", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, opts)
opts.desc = "GHCi repl quit"
vim.keymap.set("n", "<leader>hq", ht.repl.quit, opts)
