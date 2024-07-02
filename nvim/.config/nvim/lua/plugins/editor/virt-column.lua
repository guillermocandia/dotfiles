return {
  "lukas-reineke/virt-column.nvim",
  config = function()
    local vc = require("virt-column")
    vc.setup({
      virtcolumn = "120", -- TODO: setup by filetypes
      highlight = "VirtColumn",
    })
  end,
}
