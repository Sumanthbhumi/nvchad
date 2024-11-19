if true then
  return {}
end
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mason.nvim",
      "nvimtools/none-ls-extras.nvim",
      "davidmh/cspell.nvim", -- for spellchecking
    },
    event = "BufReadPre",
    config = function()
      local null_ls = require "null-ls"
      local cspell = require "cspell"
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local filetypes_to_check =
        { "javascript", "typescript", "python", "markdown" }

      -- Define sources for null-ls
      local sources = {
        -- Cspell diagnostics and code actions
        -- cspell.diagnostics.with {
        --   filetypes = filetypes_to_check,
        -- },
        -- cspell.code_actions.with {
        --   filetypes = filetypes_to_check,
        -- },

        -- Formatter sources
        -- null_ls.builtins.formatting.google_java_format.with {
        --   extra_args = { "--aosp" }, -- Android style uses 80 columns
        -- },
        -- Uncomment these if needed:
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.black,
      }

      -- Format toggle function
      local function toggle_format()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          vim.notify("Format on save disabled", vim.log.levels.INFO)
        else
          vim.notify("Format on save enabled", vim.log.levels.INFO)
        end
      end

      -- Set up the keybinding for format toggle
      vim.keymap.set("n", "<leader>fM", toggle_format, {
        desc = "Toggle format on save",
        silent = true,
      })

      -- Add command for format toggle
      vim.api.nvim_create_user_command("ToggleFormat", toggle_format, {
        desc = "Toggle format on save",
      })

      -- Setup null-ls with sources and formatting on save
      null_ls.setup {
        debug = true,
        timeout = 8000,
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds {
              group = augroup,
              buffer = bufnr,
            }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- Only format if autoformat is not disabled
                if not vim.g.disable_autoformat then
                  vim.lsp.buf.format { bufnr = bufnr }
                end
              end,
            })
          end
        end,
      }
    end,
  },
}
-- Define LazySpec
-- return {
--   "nvimtools/none-ls.nvim",
--   opts = function(_, opts)
--     local null_ls = require "null-ls"
--
--     -- Initialize opts.sources directly with null-ls sources
--     opts.sources = {
--       -- Prettier (for JavaScript, TypeScript, JSON, CSS, SCSS, HTML, Vue, etc.)
--       null_ls.builtins.formatting.prettier.with {
--         extra_args = {
--           "--print-width",
--           "80",
--           "--prose-wrap",
--           "always",
--         },
--         filetypes = {
--           "javascript",
--           "javascriptreact",
--           "typescript",
--           "typescriptreact",
--           "vue",
--           "css",
--           "scss",
--           "html",
--         },
--       },
--       -- Python formatter (black)
--       null_ls.builtins.formatting.black.with {
--         extra_args = { "--line-length", "80" },
--       },
--       -- Lua formatter (stylua)
--       null_ls.builtins.formatting.stylua.with {
--         extra_args = {
--           "--column-width",
--           "80",
--           "--indent-type",
--           "Spaces",
--           "--indent-width",
--           "2",
--         },
--       },
--       -- Go formatter (gofmt)
--       null_ls.builtins.formatting.gofmt.with {
--         extra_args = { "-w", "80" },
--       },
--       -- C/C++ formatter (clang_format)
--       null_ls.builtins.formatting.clang_format.with {
--         extra_args = { "--style={ColumnLimit: 80}" },
--       },
--       -- Java formatter (google_java_format)
--       null_ls.builtins.formatting.google_java_format.with {
--         extra_args = { "--aosp" }, -- Android style uses 80 columns
--       },
--     }
--   end,
-- }
