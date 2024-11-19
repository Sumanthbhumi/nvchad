-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = false,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true, fg = "#636DA6" },

    Normal = {
      bg = "#1E1E2E",
    },
  },
}
M.ui = {
  tabufline = {
    -- enabled = false,
    order = { "treeOffset", "buffers" },
  },
  cmp = {
    lspkind_text = true,
    style = "flat_dark",
    format_colors = {
      tailwind = true,
    },
  },
  statusline = {
    theme = "default",
    -- round = { left = "", right = "" },
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "recording",
      "abc",
      "lsp_msg",
      "%=",
      "lsp",
      "cwd",
    },
    separator_style = "arrow",
    modules = {
      abc = function()
        return vim.g.disable_autoformat and "󰉩" or ""
      end,
      xyz = "hi",
      f = "%F",
      recording = function()
        local recording = vim.fn.reg_recording()
        if recording ~= "" then
          return "%#Error#Recording @" .. recording .. "%*"
        else
          return ""
        end
      end,
    },
  },
}
M.nvdash = {
  load_on_startup = false,
  header = {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },

  buttons = {

    {
      txt = "  session",
      keys = "s",
      cmd = "lua require('persistence').load({ last = true })",
    },
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    {
      txt = "󱥚  Themes",
      keys = "th",
      cmd = ":lua require('nvchad.themes').open()",
    },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

return M
