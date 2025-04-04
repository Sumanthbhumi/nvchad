local home = os.getenv "HOME"
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

-- Get NvChad's LSP configs
local nvlsp = require "nvchad.configs.lspconfig"

local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:"
      .. home
      .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(
      home
        .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
    ),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux", -- Change to config_mac for macOS
    "-data",
    workspace_dir,
  },

  -- Use NvChad's on_attach and capabilities
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,

  root_dir = require("jdtls.setup").find_root {
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
  },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = {
        enabled = false,
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

require("jdtls").start_or_attach(config)

vim.keymap.set(
  "n",
  "<leader>jo",
  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
  { desc = "Organize Imports" }
)
vim.keymap.set(
  "n",
  "<leader>jrv",
  "<Cmd>lua require('jdtls').extract_variable()<CR>",
  { desc = "Extract Variable" }
)
vim.keymap.set(
  "v",
  "<leader>jrv",
  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
  { desc = "Extract Variable" }
)
vim.keymap.set(
  "n",
  "<leader>jrc",
  "<Cmd>lua require('jdtls').extract_constant()<CR>",
  { desc = "Extract Constant" }
)
vim.keymap.set(
  "v",
  "<leader>jrc",
  "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
  { desc = "Extract Constant" }
)
vim.keymap.set(
  "v",
  "<leader>jrm",
  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
  { desc = "Extract Method" }
)
