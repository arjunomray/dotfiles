return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,

  config = function()
    require("rose-pine").setup({
      variant = "main",
      dark_variant = "main",
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    })
    vim.cmd("colorscheme rose-pine")
  end,
}
