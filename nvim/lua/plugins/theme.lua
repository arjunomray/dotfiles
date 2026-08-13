return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = { enabled = false },
    styles = {
      comments    = { 'italic' },
      conditionals = { 'italic' },
      keywords    = { 'bold' },
      functions   = { 'bold' },
    },
    integrations = {
      blink_cmp         = true,
      cmp               = true,
      gitsigns          = true,
      markdown          = true,
      mason             = true,
      mini              = { enabled = true },
      native_lsp        = { enabled = true, underlines = { errors = { 'undercurl' }, hints = { 'underdotted' }, warnings = { 'undercurl' } } },
      neotree           = true,
      noice             = true,
      notify            = true,
      render_markdown   = true,
      snacks            = true,
      telescope         = { enabled = true },
      treesitter        = true,
      which_key         = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
