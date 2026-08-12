-- Language extras from lazyvim: Python venv, HTML autotag, C/C++ clangd, Go, Tailwind
return {
  -- Python: venv selector
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    ft = "python",
    cmd = "VenvSelect",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
    opts = {},
  },

  -- HTML/JSX auto-close and rename tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- C/C++: clangd extensions (inlay hints, memory usage, type hierarchy)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    opts = {
      inlay_hints = { inline = true },
      ast = {
        role_icons = { type = "", declaration = "", expression = "", specifier = "", statement = "", ["template argument"] = "" },
      },
    },
  },

  -- Markdown: render-markdown in normal mode
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = {} },
    },
  },
}
