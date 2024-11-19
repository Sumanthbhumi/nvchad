-- if true then
--   return {}
-- end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "comment",
        "javascript",
        "java",
        "jsdoc",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "vue",
        "svelte",
        "marksman",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
    dependencies = {
      "windwp/nvim-ts-autotag",
      "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require "nvim-treesitter.configs"

      -- Setup autotag
      require("nvim-ts-autotag").setup {
        enable = true,
        filetypes = { "html", "xml", "tsx" },
      }

      -- NvChad-inspired colors for rainbow delimiters
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#F38BA8" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#FAE3B0" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#89B4FA" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#F8BD96" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#ABE9B3" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#c099ff" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#89DCEB" })

      -- Setup rainbow delimiters
      local rainbow_delimiters = require "rainbow-delimiters"
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      -- configure treesitter
      treesitter.setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "json",
          "html",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufRead",
    config = function()
      -- Set NvChad-inspired colors for treesitter context
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#181825" })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#89B4FA" })

      require("treesitter-context").setup {
        enable = true,
        max_lines = 4,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        zindex = 20,
      }
    end,
  },
}
