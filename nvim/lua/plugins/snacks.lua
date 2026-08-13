return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Dashboard
    dashboard = {
      preset = {
        header = ' /| ､\n(°､ ｡ 7\n |､  ~ヽ\n じしf_,)〳\n\n  n e o v i m',
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File',       action = ':lua Snacks.picker.files()' },
          { icon = ' ', key = 'g', desc = 'Live Grep',       action = ':lua Snacks.picker.grep()' },
          { icon = ' ', key = 'r', desc = 'Recent Files',    action = ':lua Snacks.picker.recent()' },
          { icon = ' ', key = 's', desc = 'Restore Session', action = ':lua require("persistence").load()' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy',           action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit',            action = ':qa' },
        },
      },
    },

    -- Indent guides
    indent = {
      enabled = true,
      char = '│',
      hl = 'SnacksIndent',
    },

    -- Input (replaces vim.ui.input)
    input = { enabled = true },

    -- Notifications
    notifier = {
      enabled = true,
      timeout = 3000,
      style = 'compact',
    },

    -- Picker (replaces telescope)
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = 'right' } },
        },
      },
    },

    -- Scope (better % motion)
    scope = { enabled = true },

    -- Scroll animation
    scroll = { enabled = false },

    -- Status column
    statuscolumn = { enabled = true },

    -- Word highlights (replaces vim-illuminate)
    words = { enabled = true },
  },
  keys = {
    -- Picker
    { '<leader>ff', function() Snacks.picker.files() end,                    desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.grep() end,                     desc = 'Live Grep' },
    { '<leader>fr', function() Snacks.picker.recent() end,                   desc = 'Recent Files' },
    { '<leader>fb', function() Snacks.picker.buffers() end,                  desc = 'Buffers' },
    { '<leader>fh', function() Snacks.picker.help() end,                     desc = 'Help Pages' },
    { '<leader>fc', function() Snacks.picker.command_history() end,          desc = 'Command History' },
    { '<leader>fd', function() Snacks.picker.diagnostics() end,              desc = 'Diagnostics' },
    { '<leader>fs', function() Snacks.picker.lsp_symbols() end,              desc = 'LSP Symbols' },
    { '<leader>fw', function() Snacks.picker.lsp_workspace_symbols() end,    desc = 'Workspace Symbols' },
    { '<leader>/',  function() Snacks.picker.lines() end,                    desc = 'Buffer Search' },
    { '<leader><leader>', function() Snacks.picker.buffers() end,            desc = 'Buffers' },
    -- Explorer
    { '<leader>e',  function() Snacks.explorer() end,                        desc = 'File Explorer' },
    -- Git
    { '<leader>gl', function() Snacks.picker.git_log() end,                  desc = 'Git Log' },
    { '<leader>gb', function() Snacks.picker.git_branches() end,             desc = 'Git Branches' },
    { '<leader>gs', function() Snacks.picker.git_status() end,               desc = 'Git Status' },
    -- Misc
    { '<leader>n',  function() Snacks.notifier.show_history() end,           desc = 'Notification History' },
    { '<leader>un', function() Snacks.notifier.hide() end,                   desc = 'Dismiss Notifications' },
    { ']]',         function() Snacks.words.jump(vim.v.count1) end,          desc = 'Next word reference', mode = { 'n', 't' } },
    { '[[',         function() Snacks.words.jump(-vim.v.count1) end,         desc = 'Prev word reference', mode = { 'n', 't' } },
  },
}
