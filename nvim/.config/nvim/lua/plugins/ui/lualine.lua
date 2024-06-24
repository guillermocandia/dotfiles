local get_active_lsp = {
  function()
    local buffer_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    local null_ls_installed, null_ls = pcall(require, "null-ls")
    local buffer_client_names = {}

    for _, client in ipairs(buffer_clients) do
      if client.name ~= "null-ls" then
        table.insert(buffer_client_names, client.name)
      end
    end

    if null_ls_installed then
      local sources = null_ls.get_source({ filetype = vim.bo.filetype })
      if #sources ~= 0 then
        local r = {}
        for _, source in ipairs(sources) do
          table.insert(r, source.name)
        end
        local null_ls_text = "null-ls:" .. table.concat(r, ",")
        table.insert(buffer_client_names, null_ls_text)
      end
    end

    -- TODO include otter conf

    return table.concat(buffer_client_names, " ")
  end,
  icon = "󰌘",
}

local get_spock = {
  function()
    return ""
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "┃", --{ left = "", right = "" },
        section_separators = "┃", --{ left = "", right = "" },
        ignore_focus = { "neo-tree" },
        globalstatus = false,
      },
      sections = {
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
          get_active_lsp,
          "filetype",
          "encoding",
          "fileformat",
          "progress",
          "location",
          get_spock,
        },
        lualine_z = {},
      },
      -- inactive_sections = sections,
      -- extensions = { "neo-tree" },
    })
  end,
}
