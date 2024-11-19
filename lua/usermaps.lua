local map = vim.keymap.set

map("n", "<c-h>", "<c-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("i", "<A-l>", "<Right>", { noremap = true })
map("i", "<A-h>", "<Left>", { noremap = true })
map("i", "<A-k>", "<Up>", { noremap = true })
map("i", "<A-j>", "<Down>", { noremap = true })

map("i", "<C-J>", "<Esc>", { noremap = true })
map("v", "<C-J>", "<Esc>", { noremap = true })
map("i", "<c-bs>", "<C-W>", { noremap = true, silent = true })

map("i", "<C-h>", "<C-w>", { noremap = true }) -- Delete the previous wordkey

local function set_keymap_for_modes(modes, key1, key2)
  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, key1, key2, { noremap = true })
    vim.api.nvim_set_keymap(mode, key2, key1, { noremap = true })
  end
end

-- Define the modes
local all_modes = { "n", "v", "x", "s", "o", "i", "c" }

-- Set Z and % mappings
set_keymap_for_modes(all_modes, "Z", "%")

map("n", "<C-f>", ":Telescope find_files<CR>", { desc = "Find File" })
-- map("n", "<C-b>", ":Telescope file_browser<CR>", { desc = "File Browser" })
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle NvimTree" })

map("n", "H", "^", { noremap = true })
map("v", "H", "^", { noremap = true })
map("n", "L", "$", { noremap = true })
map("v", "L", "$h", { noremap = true })

map("n", "x", '"_x', { noremap = true, silent = true })
map({ "n", "v" }, "G", "Gzz", { noremap = true })
map(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move cursor down" }
)
map(
  "x",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move cursor down" }
)
map(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true, desc = "Move cursor up" }
)
map(
  "x",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true, desc = "Move cursor up" }
)
map("n", "<Leader>w", "<Cmd>w<CR>", { silent = true, desc = "Save buffer" })
map(
  { "n", "v" },
  "<Leader>q",
  "<Cmd>confirm q<CR>",
  { silent = true, desc = "Exit Neovim" }
)

-- Check if the plugin is available
local function is_available(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Key mappings
-- if is_available "nvim-notify" then
--   vim.keymap.set("n", "<Leader>fn", function()
--     require("telescope").extensions.notify.notify()
--   end, { desc = "Find notifications" })
-- end

-- for noice notificatons history
vim.keymap.set("n", "<Leader>fn", function()
  require("telescope").extensions.noice.noice()
end, { desc = "Find notifications with Telescope" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map(
  "n",
  "<leader>fc",
  "<cmd>Telescope grep_string<cr>",
  { desc = "Find word under cursor" }
)
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find history" })
-- map("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Find registers" })
-- map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
-- map("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
map(
  "n",
  "<leader>f/",
  "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  { desc = "Find in current buffer" }
)
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
-- map("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commits (current file)" })
-- map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
-- map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
map(
  "n",
  "<leader>fw",
  "<cmd>Telescope live_grep<cr>",
  { desc = "Find words in current path" }
)
map(
  "n",
  "<leader>f<CR>",
  "<cmd>Telescope resume<cr>",
  { desc = "Resume previous search" }
)
map("n", "<leader>fW", function()
  require("telescope.builtin").live_grep {
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  }
end, { desc = "Find words in all files" })

map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format" })

vim.keymap.set("n", "<c-t>", function()
  require("minty.huefy").open { border = true }
end, {})

-- mapping for code actions
map("n", "<leader>va", function()
  vim.lsp.buf.code_action()
end, { desc = "Code action" })
map("n", "<leader>gd", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition" })
map("n", "<leader>gr", function()
  vim.lsp.buf.references()
end, { desc = "Go to references" })
map("n", "<leader>gi", function()
  vim.lsp.buf.implementation()
end, { desc = "Go to implementation" })
map("n", "<leader>gh", function()
  vim.lsp.buf.hover()
end, { desc = "Show hover" })

map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "Show hover" })
-- rename
map("n", "<leader>gR", function()
  require "nvchad.lsp.renamer" ()
end, { desc = "Rename" })

map({ "n", "t" }, "<A-'>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.35,
      col = 0.05,
      width = 0.9,
      height = 0.9,
    },
  }
end, { desc = "terminal toggle floating term" })
map("v", "q", "<esc>")
-- map({ "n" }, "<leader>gg", function()
--   require("nvchad.term").toggle {
--     pos = "float",
--     id = "lazygit",
--     float_opts = {
--       row = 0.35,
--       col = 0.05,
--       width = 0.9,
--       height = 0.9,
--     },
--     cmd = "lazygit",
--     on_exit = function()
--       -- Close the floating window when lazygit exits
--       require("nvchad.term").toggle {
--         pos = "float",
--         id = "lazygit",
--       }
--     end,
--   }
-- end, { desc = "Toggle floating lazygit" })

vim.api.nvim_set_keymap(
  "t",
  "<C-j>",
  "<C-\\><C-n><CR>",
  { noremap = true, silent = true }
)

-- Create an autocmd group for diagnostic handling
local diagnostic_augroup =
    vim.api.nvim_create_augroup("DiagnosticHandler", { clear = true })

-- Create autocmd for cursor line handling
vim.api.nvim_create_autocmd("CursorMoved", {
  group = diagnostic_augroup,
  callback = function()
    local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.diagnostic.config {
      virtual_text = {
        format = function(diagnostic)
          if diagnostic.lnum == curr_line then
            ---@diagnostic disable-next-line: return-type-mismatch
            return nil              -- Hide virtual text for current line
          end
          return diagnostic.message -- Show virtual text for all other lines
        end,
      },
    }
  end,
})
