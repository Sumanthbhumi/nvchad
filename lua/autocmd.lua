-------------------------------------- global diagnostic toggle ------------------------------------------
function _G.toggle_global_diagnostics()
  local diagnostics_enabled = vim.g.diagnostics_enabled
  if diagnostics_enabled == nil or diagnostics_enabled then
    ---@diagnostic disable-next-line: deprecated
    vim.diagnostic.disable()
    vim.g.diagnostics_enabled = false
    vim.notify "Diagnostics disabled globally"
  else
    vim.diagnostic.enable()
    vim.g.diagnostics_enabled = true
    vim.notify "Diagnostics enabled globally"
  end
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>uD",
  ":lua toggle_global_diagnostics()<CR>",
  { noremap = true, silent = true }
)

-- Function to set indentation dynamically
local function set_indent(silent)
  local input_avail, input = pcall(
    vim.fn.input,
    "Set indent value (>0 for expandtab, <=0 for noexpandtab): "
  )
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then
      return
    end
    vim.bo.expandtab = (indent > 0)
    indent = math.abs(indent)
    vim.bo.tabstop = indent
    vim.bo.softtabstop = indent
    vim.bo.shiftwidth = indent
    if silent then
      print(
        ("Indent set to %d %s"):format(
          indent,
          vim.bo.expandtab and "expandtab" or "noexpandtab"
        )
      )
    end
  end
end

vim.keymap.set("n", "<leader>ui", function()
  set_indent(true)
end, { desc = "Set indentation" })

-------------------------------------- buffer diagnostic toggle ------------------------------------------
---@param silent? boolean if true then don't send a notification
function toggle_diagnostics(silent)
  local diagnostics_mode = vim.g.diagnostics_mode or 0
  diagnostics_mode = (diagnostics_mode + 1) % 4
  vim.g.diagnostics_mode = diagnostics_mode -- Store the mode for next time
  if diagnostics_mode == 0 then
    vim.diagnostic.config {
      virtual_text = false, -- Turn off virtual text
      signs = false,        -- Disable signs
      underline = false,    -- Disable underline
    }
    if not silent then
      vim.notify("Diagnostics off", vim.log.levels.INFO)
    end
  elseif diagnostics_mode == 1 then
    vim.diagnostic.config {
      virtual_text = false, -- Turn off virtual text
      signs = true,         -- Enable signs in the gutter
      underline = true,     -- Disable underline
    }
    if not silent then
      vim.notify("Only status diagnostics", vim.log.levels.INFO)
    end
  elseif diagnostics_mode == 2 then
    vim.diagnostic.config {
      virtual_text = true, -- Enable virtual text
      signs = false,       -- Disable gutter signs
      underline = true,    -- Disable underline
    }
    if not silent then
      vim.notify("Virtual text off", vim.log.levels.INFO)
    end
  else
    vim.diagnostic.config {
      virtual_text = true, -- Enable virtual text
      signs = true,        -- Enable signs in the gutter
      underline = true,    -- Enable underline
    }

    -- Create an autocmd group for diagnostic handling
    -- local diagnostic_augroup =
    --     vim.api.nvim_create_augroup("DiagnosticHandler", { clear = true })
    -- -- Create autocmd for cursor line handling
    -- vim.api.nvim_create_autocmd("CursorMoved", {
    --   group = diagnostic_augroup,
    --   callback = function()
    --     local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    --     vim.diagnostic.config {
    --       virtual_text = {
    --         format = function(diagnostic)
    --           if diagnostic.lnum == curr_line then
    --             ---@diagnostic disable-next-line: return-type-mismatch
    --             return nil              -- Hide virtual text for current line
    --           end
    --           return diagnostic.message -- Show virtual text for all other lines
    --         end,
    --       },
    --     }
    --   end,
    -- })
    if not silent then
      vim.notify("All diagnostics on", vim.log.levels.INFO)
    end
  end
end

vim.keymap.set("n", "<leader>ud", function()
  toggle_diagnostics(false)
end, { desc = "Toggle diagnostics" })

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match "NvimTree_" ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})
