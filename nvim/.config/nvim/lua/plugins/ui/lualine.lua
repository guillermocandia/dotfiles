local utils = require("plugins.ui.extra.lualine.utils")

local sections = {
  lualine_a = {},
  lualine_b = {
    "mode",
    "branch",
    {
      "diff",
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
    },
    utils.macro,
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
    utils.active_lsp,
    "filetype",
    "encoding",
    "fileformat",
    "progress",
    "location",
    utils.spock,
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
      extensions = { "neo-tree", "trouble" }, -- TODO trouble doesnt work
    })
  end,
}
