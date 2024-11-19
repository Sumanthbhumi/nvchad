-- if true then
--   return {}
-- end
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    -- {
    --   "<leader>o",
    --   function()
    --     if vim.bo.filetype == "neo-tree" then
    --       vim.cmd.wincmd "p"
    --     else
    --       vim.cmd.Neotree "focus"
    --     end
    --   end,
    --   desc = "Toggle Explorer Focus",
    -- },
  },

  config = function()
    local C = {
      rosewater = "#f5e0dc",
      flamingo = "#f2cdcd",
      pink = "#f5c2e7",
      mauve = "#cba6f7",
      red = "#f38ba8",
      maroon = "#eba0ac",
      peach = "#fab387",
      yellow = "#f9e2af",
      green = "#a6e3a1",
      teal = "#94e2d5",
      sky = "#89dceb",
      sapphire = "#74c7ec",
      blue = "#89b4fa",
      lavender = "#b4befe",
      text = "#cdd6f4",
      subtext1 = "#bac2de",
      subtext0 = "#a6adc8",
      overlay2 = "#9399b2",
      overlay1 = "#7f849c",
      overlay0 = "#6c7086",
      surface2 = "#585b70",
      surface1 = "#45475a",
      surface0 = "#313244",
      base = "#1e1e2e",
      mantle = "#181825",
      crust = "#11111b",
    }

    -- You can adjust this option based on your preferences
    local O = {
      transparent_background = true,
    }

    local function get_highlights()
      local active_bg = O.transparent_background and "NONE" or C.base
      local inactive_bg = O.transparent_background and "NONE" or C.mantle

      return {
        NeoTreeDirectoryName = { fg = C.blue },
        NeoTreeDirectoryIcon = { fg = C.blue },
        NeoTreeNormal = { fg = C.text, bg = "#181825" },
        NeoTreeNormalNC = { fg = C.text, bg = "#181825" },
        NeoTreeExpander = { fg = C.overlay0 },
        NeoTreeIndentMarker = { fg = C.overlay0 },
        NeoTreeRootName = { fg = C.blue, bold = true },
        NeoTreeSymbolicLinkTarget = { fg = C.pink },
        NeoTreeModified = { fg = C.peach },

        NeoTreeGitAdded = { fg = C.green },
        NeoTreeGitConflict = { fg = C.red },
        NeoTreeGitDeleted = { fg = C.red },
        NeoTreeGitIgnored = { fg = C.overlay0 },
        NeoTreeGitModified = { fg = C.yellow },
        NeoTreeGitUnstaged = { fg = C.red },
        NeoTreeGitUntracked = { fg = C.mauve },
        NeoTreeGitStaged = { fg = C.green },

        NeoTreeFloatBorder = { link = "FloatBorder" },
        NeoTreeFloatTitle = { link = "FloatTitle" },
        NeoTreeTitleBar = { fg = C.mantle, bg = C.blue },

        -- NeoTreeFileNameOpened = { fg = C.pink },
        -- NeoTreeDimText = { fg = C.overlay1 },
        -- NeoTreeFilterTerm = { fg = C.green, bold = true },
        -- NeoTreeTabActive = { bg = active_bg, fg = C.lavender, bold = true },
        -- NeoTreeTabInactive = { bg = inactive_bg, fg = C.overlay0 },
        -- NeoTreeTabSeparatorActive = { fg = active_bg, bg = active_bg },
        -- NeoTreeTabSeparatorInactive = { fg = inactive_bg, bg = inactive_bg },
        -- NeoTreeVertSplit = { fg = C.base, bg = inactive_bg },
        -- NeoTreeWinSeparator = {
        --   fg = O.transparent_background and C.surface1 or C.base,
        --   bg = O.transparent_background and "NONE" or C.base,
        -- },
        NeoTreeStatusLineNC = { fg = C.mantle, bg = C.mantle },
      }
    end

    -- Set up custom highlights
    local highlights = get_highlights()
    for name, val in pairs(highlights) do
      vim.api.nvim_set_hl(0, name, val)
    end
    vim.fn.sign_define(
      "DiagnosticSignError",
      { text = " ", texthl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
      "DiagnosticSignWarn",
      { text = " ", texthl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define(
      "DiagnosticSignInfo",
      { text = " ", texthl = "DiagnosticSignInfo" }
    )
    vim.fn.sign_define(
      "DiagnosticSignHint",
      { text = "󰌵", texthl = "DiagnosticSignHint" }
    )
    local icons = {
      folder_closed = "", -- Nerd Font icon for closed folder
      folder_open = "", -- Nerd Font icon for open folder
      folder_empty = "", -- Keep this for empty folder
      folder_empty_open = "", -- Keep this for empty folder open
      default = "", -- Default file icon (optional)
      highlight = "NeoTreeFileIcon", -- Highlight group for the file icon
      added = "", -- or use "➕"
      modified = "", -- or use "✏️"
      deleted = "", -- or use "❌"
      renamed = "➜", -- or use "📁"
      untracked = "", -- or use "🚀"
      ignored = "◌", -- or use "🚫"
      unstaged = "✗", -- or use "⚠️"
      staged = "", -- or use "✅"
      conflict = "", -- or use "❗"
    }
    local icons = {
      FoldClosed = icons.folder_closed,
      FoldOpened = icons.folder_open,
      FolderClosed = icons.folder_closed,
      FolderOpen = icons.folder_open,
      FolderEmpty = icons.folder_empty,
      DefaultFile = icons.default,
      FileModified = icons.modified,
      GitAdd = icons.added,
      GitDelete = icons.deleted,
      GitChange = icons.modified,
      GitRenamed = icons.renamed,
      GitUntracked = icons.untracked,
      GitIgnored = icons.ignored,
      GitUnstaged = icons.unstaged,
      GitStaged = icons.staged,
      GitConflict = icons.conflict,
      Diagnostic = "",
      Git = "",
    }
    local get_icon = function(name)
      return icons[name]
    end

    -- Check if git is available
    local git_available = vim.fn.executable "git" == 1

    -- Create autocommands
    local function setup_autocmds()
      -- Autocommand for directory detection
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Open Neo-Tree on startup with directory",
        callback = function()
          if package.loaded["neo-tree"] then
            return true
          end
          local stats = (vim.uv or vim.loop).fs_stat(
            vim.api.nvim_buf_get_name(0)
          )
          if stats and stats.type == "directory" then
            require("lazy").load { plugins = { "neo-tree.nvim" } }
            return true
          end
        end,
      })

      -- Autocommand for lazygit refresh
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit*",
        desc = "Refresh Neo-Tree sources when closing lazygit",
        callback = function()
          local manager_avail, manager =
            pcall(require, "neo-tree.sources.manager")
          if manager_avail then
            for _, source in ipairs {
              "filesystem",
              "git_status",
              "document_symbols",
            } do
              local module = "neo-tree.sources." .. source
              if package.loaded[module] then
                manager.refresh(require(module).name)
              end
            end
          end
        end,
      })
    end

    -- Setup sources
    local sources = {
      {
        source = "filesystem",
        display_name = get_icon "FolderClosed" .. "File",
      },
      { source = "buffers", display_name = get_icon "DefaultFile" .. "Bufs" },
      {
        source = "diagnostics",
        display_name = get_icon "Diagnostic" .. "Diagnostic",
      },
    }
    if git_available then
      table.insert(
        sources,
        3,
        { source = "git_status", display_name = get_icon "Git" .. "Git" }
      )
    end

    -- Configure Neo-tree
    require("neo-tree").setup {
      enable_git_status = git_available,
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      sources = {
        "filesystem",
        "buffers",
        git_available and "git_status" or nil,
      },
      source_selector = {
        winbar = false,
        content_layout = "center",
        sources = sources,
      },
      default_component_configs = {
        indent = {
          padding = 0,
          expander_collapsed = get_icon "FoldClosed",
          expander_expanded = get_icon "FoldOpened",
        },
        icon = {
          folder_closed = get_icon "FolderClosed",
          folder_open = get_icon "FolderOpen",
          folder_empty = get_icon "FolderEmpty",
          folder_empty_open = get_icon "FolderEmpty",
          default = get_icon "DefaultFile",
        },
        modified = { symbol = get_icon "FileModified" },
        git_status = {
          symbols = {
            added = get_icon "GitAdd",
            deleted = get_icon "GitDelete",
            modified = get_icon "GitChange",
            renamed = get_icon "GitRenamed",
            untracked = get_icon "GitUntracked",
            ignored = get_icon "GitIgnored",
            unstaged = get_icon "GitUnstaged",
            staged = get_icon "GitStaged",
            conflict = get_icon "GitConflict",
          },
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- System-specific open command
          vim.fn.jobstart(
            vim.fn.has "win32" == 1 and { "cmd.exe", "/c", "start", '""', path }
              or vim.fn.has "macunix" == 1 and { "open", path }
              or { "xdg-open", path }
          )
        end,
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if node:has_children() and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(
              state,
              node:get_parent_id()
            )
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, select the next child
              if node.type == "file" then
                state.commands.open(state)
              else
                require("neo-tree.ui.renderer").focus_node(
                  state,
                  node:get_child_ids()[1]
                )
              end
            end
          else -- if has no children
            state.commands.open(state)
          end
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ""
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item)
              return ("%s: %s"):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,
      },
      window = {
        width = 30,
        mappings = {
          ["<S-CR>"] = "system_open",
          ["<Space>"] = false,
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          O = "system_open",
          Y = "copy_selector",
          h = "parent_or_close",
          l = "child_or_open",
        },
        fuzzy_finder_mappings = {
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = { hide_gitignored = git_available },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
            vim.opt_local.foldcolumn = "0"
          end,
        },
      },
    }

    -- Setup telescope integration if available
    local telescope_available, _ = pcall(require, "telescope.builtin")
    if telescope_available then
      require("neo-tree").setup_commands = function(state)
        local node = state.tree:get_node()
        local path = node.type == "file" and node:get_parent_id()
          or node:get_id()
        require("telescope.builtin").find_files { cwd = path }
      end
    end

    setup_autocmds()
  end,
}
