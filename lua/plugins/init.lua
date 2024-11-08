return {

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "BufRead",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
      { "<C-n>", mode = { "n", "v" } },
    },
    config = function()
      local mc = require "multicursor-nvim"

      mc.setup()

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ "n", "v" }, "<up>", function()
        mc.addCursor "k"
      end)
      vim.keymap.set({ "n", "v" }, "<down>", function()
        mc.addCursor "j"
      end)

      -- Add a cursor and jump to the next word under cursor.
      vim.keymap.set({ "n", "v" }, "<c-n>", function()
        mc.addCursor "*"
      end)

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ "n", "v" }, "<c-s>", function()
        mc.skipCursor "*"
      end)

      -- Rotate the main cursor.
      vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
      vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      vim.keymap.set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      vim.keymap.set("v", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      vim.keymap.set("v", "I", mc.insertVisual)
      vim.keymap.set("v", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      vim.keymap.set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      vim.keymap.set("v", "<leader>t", function()
        mc.transposeCursors(1)
      end)
      vim.keymap.set("v", "<leader>T", function()
        mc.transposeCursors(-1)
      end)

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  },

  {
    -- for indentation in markdown
    "bullets-vim/bullets.vim",
    ft = { "markdown" },
  },

  {
    "mbbill/undotree",
    event = "VeryLazy",
    vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle),
  },

  {
    -- for creation of files
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", mode = "n" },
      { "<leader>-", mode = "n" },
    },
    cmd = "Oil",
    config = function()
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }
      -- Open parent directory in current window
      vim.keymap.set(
        "n",
        "-",
        "<CMD>Oil<CR>",
        { desc = "Open parent directory" }
      )
      -- Open parent directory in floating window
      vim.keymap.set(
        "n",
        "<leader>-",
        require("oil").toggle_float,
        { desc = "Open parent directory in floating window" }
      )
    end,
  },
  {
    -- vim motions in cmd
    "smilhey/ed-cmd.nvim",
    event = "CmdlineEnter",
    config = function()
      require("ed-cmd").setup {
        -- Those are the default options, you can just call setup({}) if you don't want to change the defaults
        cmdline = {
          keymaps = {
            edit = "<C-J>",
            execute = "<CR>",
            close = { "<C-C>", "q" },
          },
        },
        -- You enter normal mode in the cmdline with edit, execute a
        -- command from normal mode with execute and close the cmdline in
        -- normal mode with close

        -- The keymaps fields also accept list of keymaps
        -- cmdline = { keymaps = { close = { "<C-C>" , "q" } } },
        pumenu = { max_items = 100 },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "nvim-java/nvim-java",
    config = function()
      require "config.java"
    end,
  },
  {
    -- custom snippets
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").load {
        paths = "~/.config/nvim/lua/snippets/",
      }
    end,
  },
  {
    -- timer
    "siduck/timerly",
    cmd = "TimerlyToggle",
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    event = "BufReadPre",
    config = function()
      local null_ls = require "null-ls"
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.google_java_format,
        -- null_ls.builtins.diagnostics.checkstyle.with {
        --   extra_args = {
        --     "-c",
        --     vim.fn.expand "$HOME/.config/checkstyle/google_checks.xml",
        --   },
        --   filetypes = { "java" },
        -- },
        null_ls.builtins.formatting.prettier.with {
          filetypes = { "html", "css", "javascript", "typescript" },
        },
      }

      null_ls.setup {
        debug = true,
        timeout = 8000,
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }

      -- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
    end,
  },
}
