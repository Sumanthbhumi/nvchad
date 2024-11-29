return {
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>sJ",
        "<CMD>TSJToggle<CR>",
        desc = "Toggle Inline/Block with treesj",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    "echasnovski/mini.splitjoin",
    keys = {
      { "<leader>sj" },
    },
    version = "*",
    config = function()
      require("mini.splitjoin").setup {
        mappings = {
          toggle = "<leader>sj",
          split = "",
          join = "",
        },
      }
    end,
  },
}
