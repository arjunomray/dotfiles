return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "bold" },
        functions = { "bold" },
      },
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
        telescope = { enabled = true },
        which_key = true,
        mini = { enabled = true },
      },
    })
    vim.cmd("colorscheme catppuccin-mocha")
  end,
}
