-- if true then
--   return {}
-- end

return {
  {
    "romainl/vim-cool",
    event = { "CursorMoved", "InsertEnter" },
    config = function()
      vim.g.CoolTotalMatches = 1
      --
      local colors = require("base46").get_theme_tb "base_30"

      -- Set the search highlight colors to match NvChad theme
      vim.api.nvim_set_hl(0, "Search", {
        bg = colors.blue,
        fg = colors.black,
      })

      vim.api.nvim_set_hl(0, "IncSearch", {
        bg = colors.red,
        fg = colors.black,
      })

      -- Add autocmd to update colors when colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local updated_colors = require("base46").get_theme_tb "base_30"
          vim.api.nvim_set_hl(0, "Search", {
            bg = updated_colors.blue,
            fg = updated_colors.black,
          })
          vim.api.nvim_set_hl(0, "IncSearch", {
            bg = updated_colors.red,
            fg = updated_colors.black,
          })
        end,
      })
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Search settings
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Optional: manual toggle for search highlighting
      -- vim.keymap.set(
      --   "n",
      --   "<leader>h",
      --   ":noh<CR>",
      --   { silent = true, desc = "Clear search highlight" }
      -- )
    end,
  },
}
