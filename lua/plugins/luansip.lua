return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    -- Load snippets from custom Lua snippet folder
    require("luasnip.loaders.from_lua").load {
      paths = "~/.config/nvim/lua/snippets/",
    }

    -- Load snippets from VSCode-style snippet collection
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
