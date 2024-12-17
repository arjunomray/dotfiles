return {
  'nvimdev/dashboard-nvim',
  event = 'vimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      theme = 'hyper',
      config = {
        header = {
          "",
          " /| ､      ",
          "(°､ ｡ 7    ",
          " |､  ~ヽ   ",
          " じしf_,)〳",
          "",
          "",
          "Make fun things. :)",
          "",
        },           --your header

        footer = {}, --your footer
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
