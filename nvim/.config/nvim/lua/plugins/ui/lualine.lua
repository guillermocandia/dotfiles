local utils = require("extra.lualine.utils")

local sections = {
  lualine_a = {},
  lualine_b = {
    "mode",
    "branch",
    {
      "diff",
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
    },
  },
  lualine_c = {},
  lualine_x = {
    {
      "filename",
      newfile_status = true,
      path = 1,
    },
  },
  lualine_y = {
    {
      "diagnostics",
      update_in_insert = true,
      always_visible = true,
    },
    utils.get_active_lsp,
    "filetype",
    "encoding",
    "fileformat",
    "progress",
    "location",
    utils.get_spock,
  },
  lualine_z = {},
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "│",
        section_separators = "│",
        ignore_focus = { "neo-tree" },
        globalstatus = false,
      },
      sections = sections,
      inactive_sections = sections,
      extensions = { "neo-tree" },
    })
  end,
}
