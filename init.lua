vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
  { import = "extras" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require "toggle"
require "usermaps"
require "autocmd"

vim.schedule(function()
  require "mappings"
end)

local v = vim.api
v.nvim_set_hl(0, "Visual", { fg = "NONE", bg = "#3C3C5E" })
v.nvim_set_hl(0, "Comment", { fg = "#959DD4", bg = "NONE", italic = true })
v.nvim_set_hl(0, "CursorLineNr", { fg = "#959DD4", bg = "NONE", bold = true })
-- Undoes NvChad's effect of clearing CursorLine
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   pattern = { "*" },
--   command = "highlight link CursorLine CursorColumn",
-- })
--
-- vim.cmd.colorscheme "catppuccin"
