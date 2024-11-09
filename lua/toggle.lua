-------------------------------------- buffer keymaps ------------------------------------------
local function close_all_buffers_except_current()
  local current = vim.fn.bufnr "%"
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(buffers) do
    if buf.bufnr ~= current then
      vim.cmd(string.format("bdelete %d", buf.bufnr))
    end
  end
end

local function close_all_buffers()
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(buffers) do
    vim.cmd(string.format("bdelete %d", buf.bufnr))
  end
end

local function close_buffers_to_left()
  local current = vim.fn.bufnr "%"
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(buffers) do
    if buf.bufnr < current then
      vim.cmd(string.format("bdelete %d", buf.bufnr))
    end
  end
end

local function close_buffers_to_right()
  local current = vim.fn.bufnr "%"
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(buffers) do
    if buf.bufnr > current then
      vim.cmd(string.format("bdelete %d", buf.bufnr))
    end
  end
end

vim.keymap.set(
  "n",
  "<leader>bc",
  close_all_buffers_except_current,
  { desc = "Close all buffers except current" }
)
vim.keymap.set(
  "n",
  "<leader>bC",
  close_all_buffers,
  { desc = "Close all buffers" }
)
vim.keymap.set(
  "n",
  "<leader>bl",
  close_buffers_to_left,
  { desc = "Close all buffers to the left" }
)
vim.keymap.set(
  "n",
  "<leader>br",
  close_buffers_to_right,
  { desc = "Close all buffers to the right" }
)
