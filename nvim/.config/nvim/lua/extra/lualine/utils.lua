local M = {}
M.get_active_lsp = {
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
        local null_ls_text = "null-ls:" .. table.concat(r, "┊")
        table.insert(buffer_client_names, null_ls_text)
      end
    end

    -- TODO: include otter conf

    return table.concat(buffer_client_names, "┆")
  end,
  icon = "󰌘",
}

M.get_spock = {
  function()
    return ""
  end,
}

return M
