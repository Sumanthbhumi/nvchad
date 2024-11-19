-- if true then
--   return {}
-- end

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
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
          signature = {
            auto_open = {
              trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
            },
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
              -- event = "notify",
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
                { find = "No signature help available" },
              },
            },
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
  {
    "rcarriga/nvim-notify",
    lazy = false,
    enabled = true,
  },
}
