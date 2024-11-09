-- Initialize the configuration table
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
  },
  format_on_save = function()
    if vim.g.disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

-- Function to toggle format on save
local function toggle_format()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    vim.notify("Format on save disabled", vim.log.levels.INFO)
  else
    vim.notify("Format on save enabled", vim.log.levels.INFO)
  end
end

-- Set up the keybinding
vim.keymap.set("n", "<leader>fM", toggle_format, {
  desc = "Toggle format on save",
  silent = true,
})

return options
