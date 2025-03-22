-- if true then
--   return {}
-- end
return {

  {
    -- css values for the tailwind class
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
    },
    opts = {
      border = "rounded", -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = true, -- Sets the preview as the current window
      copy_register = "", -- The register to copy values to,
      keymaps = {
        copy = "<C-y>", -- Normal mode keymap to copy the CSS values between {}
      },
    },
  },
  {
    -- google error from neovim
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>vi",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "<leader>vs",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
      {
        mode = { "n" },
        "<leader>vh",
        function()
          require("wtf").history()
        end,
        desc = "Populate the quickfix list with previous chat history",
      },
      {
        mode = { "n" },
        "<leader>vg",
        function()
          require("wtf").grep_history()
        end,
        desc = "Grep previous chat history with Telescope",
      },
    },
  },

  -- {
  --   -- for better buffer management
  --   "jackMort/tide.nvim",
  --   keys = { "<CR>" },
  --   config = function()
  --     require("tide").setup {
  --       keys = {
  --         leader = "<CR>",                        -- Leader key to prefix all Tide commands
  --         panel = "<CR>",                         -- Open the panel (uses leader key as prefix)
  --         add_item = "a",                         -- Add a new item to the list (leader + 'a')
  --         delete = "d",                           -- Remove an item from the list (leader + 'd')
  --         clear_all = "x",                        -- Clear all items (leader + 'x')
  --         horizontal = "-",                       -- Split window horizontally (leader + '-')
  --         vertical = "|",                         -- Split window vertically (leader + '|')
  --       },
  --       animation_duration = 100,                 -- Animation duration in milliseconds
  --       animation_fps = 30,                       -- Frames per second for animations
  --       hints = {
  --         dictionary = "qwertzuiopsfghjklycvbnm", -- Key hints for quick access
  --       },
  --     }
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufReadPost", -- event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   enable = true,
  -- },
  {
    -- for indent highlight
    "echasnovski/mini.indentscope",
    event = "BufRead",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#F5C2E7" })
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    -- for session management
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    -- for floating linting with adaptable width
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    -- show keybindings while typing
    "siduck/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "bottom-center",
      timeout = 1,
      maxkeys = 5,
      show_count = true,
      -- more opts
      keyformat = {
        ["<BS>"] = "󰁮 ",
        ["<CR>"] = "󰘌",
        ["<Space>"] = "󱁐",
        ["<Up>"] = "󰁝",
        ["<Down>"] = "󰁅",
        ["<Left>"] = "󰁍",
        ["<Right>"] = "󰁔",
        ["<PageUp>"] = "Page 󰁝",
        ["<PageDown>"] = "Page 󰁅",
        ["<M>"] = "A",
        ["<C>"] = "C",
      },
    },
  },

  {
    -- for java with extra mason registry like spring, lombok
    "nvim-java/nvim-java",
    lazy = true,
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
  {
    -- leetcoe in neovim :vim leetcode.nvim
    "kawre/leetcode.nvim",
    enabled = true,
    lazy = false,
    opts = {
      lang = "java",
      -- configuration goes here
    },
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<leader>o",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        position = "center",
      },
      navigate = {
        cancel_snipe = "q",
      },
    },
  },

  {
    "echasnovski/mini.move",
    version = "*",
    event = "BufRead",
    opts = {
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    },
    options = {
      reindent_linewise = true,
    },
  },
}
