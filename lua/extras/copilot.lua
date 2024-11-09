return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  build = ":Copilot auth",
  opts = {
    filetypes = {
      ["*"] = true,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-i>",
        accept_word = "<M-n>",
        accept_line = "<M-o>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-[>",
      },
    },
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom",
        ratio = 0.4,
      },
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
