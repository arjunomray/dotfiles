-- File explorer (right side)
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>E', ':Neotree reveal<CR>', desc = 'NeoTree (reveal)', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        position = 'right',
        mappings = { ['<leader>E'] = 'close_window' },
      },
    },
  },
}
