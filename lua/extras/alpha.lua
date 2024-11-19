-- local config = function()
--   local alpha = require "alpha"
--   local dashboard = require "alpha.themes.dashboard"
--   dashboard.section.header.val = {
--
--     [[          ▀████▀▄▄              ▄█ ]],
--     [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
--     [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
--     [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
--     [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
--     [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
--     [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
--     [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
--     [[   █   █  █      ▄▄           ▄▀   ]],
--   }
--
--   dashboard.section.buttons.val = {
--     -- function() require("persistence").load({ last = true }) end -- for session
--     dashboard.button("n", "last session", ":lua require('persistence').load({ last = true })<CR>"),
--
--     dashboard.button("f", "Find file", ":Telescope find_files <CR>"),
--     dashboard.button("e", "New file", ":ene <BAR> startinsert <CR>"),
--     dashboard.button("r", "Recently used files", ":Telescope oldfiles <CR>"),
--     dashboard.button("t", "Find text", ":Telescope live_grep <CR>"),
--     dashboard.button("c", "Configuration", ":e ~/.config/nvim/init.vim<CR>"),
--     dashboard.button("q", "Quit Neovim", ":qa<CR>"),
--   }
--
--   local function footer()
--     return "Don't Stop Until You are Proud..."
--   end
--
--   dashboard.section.footer.val = footer()
--
--   dashboard.section.footer.opts.hl = "Type"
--   dashboard.section.header.opts.hl = "Include"
--   dashboard.section.buttons.opts.hl = "Keyword"
--
--   alpha.setup(dashboard.opts)
-- end
--
-- return {
--   "goolord/alpha-nvim",
--   event = "VimEnter",
--   config = config,
--   dependencies = { { "nvim-tree/nvim-web-devicons", "ColaMint/pokemon.nvim" } },
-- }

if true then
  return {
    {
      "goolord/alpha-nvim",
      lazy = true,
      event = "VimEnter",
      opts = function()
        local dashboard = require "alpha.themes.dashboard"
        local logo = [[

   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝


    ]]

        local function getGreeting(name)
          local tableTime = os.date "*t"
          local datetime = os.date " %Y-%m-%d   %H:%M:%S"
          local hour = tableTime.hour
          local greetingsTable = {
            [1] = "  Sleep well",
            [2] = "  Good morning",
            [3] = "  Good afternoon",
            [4] = "  Good evening",
            [5] = "󰖔  Good night",
          }
          local greetingIndex = 0
          if hour == 23 or hour < 7 then
            greetingIndex = 1
          elseif hour < 12 then
            greetingIndex = 2
          elseif hour >= 12 and hour < 18 then
            greetingIndex = 3
          elseif hour >= 18 and hour < 21 then
            greetingIndex = 4
          elseif hour >= 21 then
            greetingIndex = 5
          end
          return "\t\t"
              .. datetime
              .. "\t"
              .. greetingsTable[greetingIndex]
              .. ", "
              .. name
        end

        local userName = "Bobby"
        local greeting = getGreeting(userName)
        dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
        dashboard.section.buttons.val = {
          dashboard.button(
            "s",
            " " .. " Last session",
            ":lua require('persistence').load({ last = true })<CR>"
          ),
          dashboard.button(
            "r",
            "󰄉 " .. " Recent files",
            ":Telescope oldfiles <CR>"
          ),
          dashboard.button(
            "c",
            " " .. " Config",
            ":e ~/.config/nvim/init.lua <CR>"
          ),
          dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
          dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }

        -- set highlight
        for _, button in ipairs(dashboard.section.buttons.val) do
          button.opts.hl = "AlphaButtons"
          button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 5
        return dashboard
      end,
      config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
          vim.cmd.close()
          vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
              require("lazy").show()
            end,
          })
        end

        require("alpha").setup(dashboard.opts)

        -- Define custom colors for the dashboard
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa", bold = true })   -- Pink header text
        vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#cba6f7", bold = true })  -- Purple button text
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#a6e3a1", bold = true }) -- Green shortcut text
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#f2cdcd", italic = true }) -- Cyan footer text

        -- Modified startup stats display
        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyVimStarted",
          callback = function()
            local stats = require("lazy").stats()
            local ms = math.floor(stats.startuptime) .. " ms"
            local version = "  󰥱 v"
                .. vim.version().major
                .. "."
                .. vim.version().minor
                .. "."
                .. vim.version().patch
            local plugins = "⚡ Loaded "
                .. stats.loaded
                .. "/"
                .. stats.count
                .. " plugins in "
                .. ms
            local footer = version .. "\t" .. plugins .. "\n"
            dashboard.section.footer.val = footer
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end,
    },
  }
end
-- return {
--   {
--     "goolord/alpha-nvim",
--     lazy = true,
--     event = "VimEnter",
--     opts = function()
--       local dashboard = require "alpha.themes.dashboard"
--       local logo = [[
--
--    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
--    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
--    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
--    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
--
--     ]]
--
--       local function getGreeting(name)
--         local tableTime = os.date "*t"
--         local datetime = os.date " %Y-%m-%d   %H:%M:%S"
--         local hour = tableTime.hour
--         local greetingsTable = {
--           [1] = "  Sleep well",
--           [2] = "  Good morning",
--           [3] = "  Good afternoon",
--           [4] = "  Good evening",
--           [5] = "󰖔  Good night",
--         }
--         local greetingIndex = 0
--         if hour == 23 or hour < 7 then
--           greetingIndex = 1
--         elseif hour < 12 then
--           greetingIndex = 2
--         elseif hour >= 12 and hour < 18 then
--           greetingIndex = 3
--         elseif hour >= 18 and hour < 21 then
--           greetingIndex = 4
--         elseif hour >= 21 then
--           greetingIndex = 5
--         end
--         return "\t\t"
--             .. datetime
--             .. "\t"
--             .. greetingsTable[greetingIndex]
--             .. ", "
--             .. name
--       end
--
--       local userName = "Bobby"
--       local greeting = getGreeting(userName)
--       dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
--       dashboard.section.buttons.val = {
--         dashboard.button(
--           "s",
--           " " .. " Last session",
--           ":lua require('persistence').load({ last = true })<CR>"
--         ),
--         dashboard.button(
--           "r",
--           "󰄉 " .. " Recent files",
--           ":Telescope oldfiles <CR>"
--         ),
--         dashboard.button(
--           "c",
--           " " .. " Config",
--           ":e ~/.config/nvim/init.lua <CR>"
--         ),
--         dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
--         dashboard.button("q", " " .. " Quit", ":qa<CR>"),
--       }
--
--       -- set highlight
--       for _, button in ipairs(dashboard.section.buttons.val) do
--         button.opts.hl = "AlphaButtons"
--         button.opts.hl_shortcut = "AlphaShortcut"
--       end
--       dashboard.section.header.opts.hl = "AlphaHeader"
--       dashboard.section.buttons.opts.hl = "AlphaButtons"
--       dashboard.section.footer.opts.hl = "AlphaFooter"
--       dashboard.opts.layout[1].val = 5
--       return dashboard
--     end,
--     config = function(_, dashboard)
--       -- close Lazy and re-open when the dashboard is ready
--       if vim.o.filetype == "lazy" then
--         vim.cmd.close()
--         vim.api.nvim_create_autocmd("User", {
--           pattern = "AlphaReady",
--           callback = function()
--             require("lazy").show()
--           end,
--         })
--       end
--
--       require("alpha").setup(dashboard.opts)
--
--       -- Define custom colors for the dashboard
--       vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa", bold = true })   -- Pink header text
--       vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#cba6f7", bold = true })  -- Purple button text
--       vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#a6e3a1", bold = true }) -- Green shortcut text
--       vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#f2cdcd", italic = true }) -- Cyan footer text
--       vim.api.nvim_create_autocmd("User", {
--         pattern = "LazyVimStarted",
--         callback = function()
--           local stats = require("lazy").stats()
--           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--           local version = "  󰥱 v"
--               .. vim.version().major
--               .. "."
--               .. vim.version().minor
--               .. "."
--               .. vim.version().patch
--           local plugins = "⚡Neovim loaded "
--               .. stats.count
--               .. " plugins in "
--               .. ms
--               .. "ms"
--           local footer = version .. "\t" .. plugins .. "\n"
--           dashboard.section.footer.val = footer
--           pcall(vim.cmd.AlphaRedraw)
--         end,
--       })
--     end,
--   },
-- }
