if true then
  return {

    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      },
      config = function(_, opts)
        require("noice").setup {
          lsp = {
            progress = {
              enabled = false,
            },

            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          routes = {
            {
              filter = {
                event = "msg_show",
                any = {
                  { kind = "", find = "written" },
                  { find = "%d+L, %d+B" },
                  { find = "; after #%d+" },
                  { find = "; before #%d+" },
                  { find = "^%d+ fewer lines$" },
                  { find = "^%d+ more lines$" },
                  { find = "^%d+ lines yanked$" },
                  { find = "^%d+ lines indented$" },
                  { find = "No information available" },
                },
              },
              opts = { skip = true },
            },
          },
          cmdline = {
            view = "cmdline",
          },
        }
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
  }
end

local M = {
  "folke/noice.nvim",
  dependencies = {
    -- "rcarriga/nvim-notify",
  },
  priority = 1000,
  lazy = false,
}

M.opts = {
  lsp = {
    progress = {
      enabled = false,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = false,
  },
  -- for cmdline popup which i disable below this comment
  -- views = {
  --   cmdline_popup = {
  --     border = {
  --       padding = { 1, 2 },
  --     },
  --     filter_options = {},
  --     win_options = {
  --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
  --     },
  --   },
  -- },

  cmdline = {
    view = "cmdline",
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
          { find = "^%d+ fewer lines$" },
          { find = "^%d+ more lines$" },
          { find = "^%d+ lines yanked$" },
          { find = "No information available" },
          -- { find = "written" },
        },
      },
      view = "mini",
    },
    {
      filter = {
        event = "lsp",
        any = {
          { kind = "progress", find = "Validate documents" },
          { kind = "progress", find = "Publish Diagnostics" },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        any = {
          { find = "clipboard: error: Nothing is copied" },
        },
      },
      opts = { skip = true },
    },
  },
}

return M
