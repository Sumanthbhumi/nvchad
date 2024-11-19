-- if true then
--   return {}
-- end
return {
  {
    "nvim-telescope/telescope.nvim",

    opts = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette()
      opts.defaults.mappings.i = {
        ["<Esc>"] = require("telescope.actions").close,
      }
      -- Define Telescope colors
      local TelescopeColor = {
        TelescopeMatching = { fg = colors.blue, bold = true, italic = true },
        TelescopeSelection = {
          -- fg = colors.mantle,
          bg = "#3C3C5E",
          -- bold = true,
        },
        -- TelescopePromptPrefix = { bg = colors.surface0 },
        -- TelescopePromptNormal = { bg = colors.surface0 },
        -- TelescopeResultsNormal = { bg = colors.mantle },
        -- TelescopePreviewNormal = { bg = colors.mantle },
        -- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        -- TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        -- TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        -- TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        -- TelescopeResultsTitle = { fg = colors.mantle },
        -- TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      -- -- Set highlights
      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist
              + require("telescope.actions").open_qflist,
            ["<C-x>"] = require("telescope.actions").smart_send_to_loclist
              + require("telescope.actions").open_loclist,
          },
        },
        path_display = {
          "filename_first",
        },
        file_ignore_patterns = vim.list_extend(
          opts.defaults.file_ignore_patterns or {},
          {
            "node_modules",
            ".gitignore",
            ".git",
            ".yml",
            ".lock",
            ".log",
            ".cache",
            ".toml",
            ".png",
            ".jpeg",
            ".svg",
            ".ico",
            ".class",
            ".jar",
          }
        ),
      })
      return opts
    end,
  },
}
