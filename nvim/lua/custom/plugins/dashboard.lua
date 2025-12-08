return {
  'nvimdev/dashboard-nvim',
  event = 'vimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      theme = 'doom',
      config = {
        package = { enable = true },
        project = { enable = false },
        header = {
          '',
          ' /| ､      ',
          '(°､ ｡ 7    ',
          ' |､  ~ヽ   ',
          ' じしf_,)〳',
          '',
          '',
          'Make fun things. :)',
          '',
        }, --your header

        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'b',
            keymap = 'SPC f f',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(2)',
          },
          {
            icon = ' ',
            desc = 'Find Dotfiles',
            key = 'f',
            keymap = 'SPC f d',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(3)',
          },
        },
        footer = {
          '',
          '',
          'welcome back arjun',
          '',
        }, --your footer
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
