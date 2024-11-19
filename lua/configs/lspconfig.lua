-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "marksman", "gopls", "jdtls" }
local nvlsp = require "nvchad.configs.lspconfig"

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "javascript",
    "typescriptreact",
    "javascriptreact",
  },
}

lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "javascript",
    "html",
    "css",
    "scss",
    "typescriptreact",
    "javascriptreact",
  },
}

lspconfig.jdtls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    java = {
      format = {
        enabled = false, -- Enable formatting
        comments = {
          enabled = true, -- Enable comment formatting
          wrap = true, -- Enable comment wrapping
          wrapWidth = 80, -- Set comment wrap width
        },
        -- Disable other formatting
        code = {
          enabled = false, -- Disable code formatting
        },
      },
    },
  },
}

-- for markdown with marksman
-- lspconfig.marksman.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = {
--     "markdown",
--   },
-- }
--
-- lspconfig.markdown_oxide.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = {
--     "markdown",
--   },
-- }
-- lspconfig.textlsp.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = { "text", "tex", "org", "md" },
-- }
-- for rust

lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- ls.filetype_extend("javascriptreact", { "html" })

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
