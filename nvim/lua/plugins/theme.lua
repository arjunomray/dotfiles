return {
  "ellisonleao/gruvbox.nvim",
  opts = {
    contrast = "hard",
    transparent_mode = true,
  },

  config = function(_, opts)
    vim.o.background = "dark"
    require("gruvbox").setup(opts)
    vim.cmd("colorscheme gruvbox")
  end,
}
