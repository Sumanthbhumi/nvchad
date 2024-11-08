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
M.nvdash = {
  load_on_startup = true,
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
      "lsp_msg",
      "%=",
      "lsp",
      "cwd",
    },
    separator_style = "round",
    modules = {
      abc = function()
        return "hi"
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

return M
