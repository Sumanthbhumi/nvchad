return {
  -- init.lua
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   ft = { "markdown" },
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true, -- or `opts = {}`
  -- },

  {
    -- for indentation in markdown (like for points)
    "bullets-vim/bullets.vim",
    ft = { "markdown" },
  },

  {
    -- better ui for markdown
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    }, -- if you use the mini.nvim suite
  },

  {
    -- live preview of markdown in browser
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
