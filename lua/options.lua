require "nvchad.options"

local opt = vim.opt
local o = vim.o
local g = vim.g
local v = vim.api
-------------------------------------- options ------------------------------------------
-- sumanth
opt.scrolloff = 5    -- Set scrolloff option
opt.swapfile = false --Swapfile

o.laststatus = 3
o.showmode = true
o.cmdheight = 1

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
-- opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep)
    .. delim
    .. vim.env.PATH

v.nvim_set_hl(0, "Comment", { fg = "#959DD4", bg = "NONE", italic = true })
v.nvim_set_hl(0, "CursorLineNr", { fg = "#959DD4", bg = "NONE", bold = true })
v.nvim_set_hl(0, "LineNrAbove", { fg = "#636DA6" })
v.nvim_set_hl(0, "LineNrBelow", { fg = "#636DA6" })

-------------------------------------- Restore cursor position ------------------------------------------
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
v.nvim_clear_autocmds { group = lastplace }
v.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = { "*" },
  desc = "remember last cursor place",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.cmd [[autocmd FileType * set formatoptions-=ro]]
-- get linting in floating window with <leader>gH
-- vim.keymap.set("n", "<Leader>gH", vim.diagnostic.open_float, { noremap = true, silent = true })

-------------------------------------- highlight on yanked ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 100,
    }
  end,
})

-------------------------------------- for colorcolumn ------------------------------------------

local set = vim.api

set.nvim_set_hl(0, "ColorColumn", { bg = "#181826" })
set.nvim_create_autocmd("Filetype", {
  ---@diagnostic disable-next-line: undefined-global
  group = augroup,
  pattern = {
    "java",
    "javascript",
    "typescript",
    "lua",
    "python",
    "c",
    "cpp",
    "rust",
    "go",
    "javascriptreact",
    "typescriptreact",
  },
  command = "setlocal  colorcolumn=81",
})
