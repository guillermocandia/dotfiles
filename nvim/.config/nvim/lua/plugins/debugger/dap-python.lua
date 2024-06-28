return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local python = require("dap-python")
    python.setup("python")

    vim.keymap.set("n", "<leader>dpm", function()
      python.test_method()
    end, { desc = "Test method" })
    vim.keymap.set("n", "<leader>dpc", function()
      python.test_class()
    end, { desc = "Test class" })
    vim.keymap.set("n", "<leader>dps", function()
      python.debug_selection()
    end, { desc = "Debug selection" })
  end,
}
-- TODO try test
-- TODO try django test
-- TODO try with venv
