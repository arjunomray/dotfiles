-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Git signs (minimal — full config in kickstart/plugins/gitsigns.lua)
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '▎' },
      },
    },
  },

  -- mini.nvim (surround + ai text objects)
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },

  -- Treesitter (new rewrite API)
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'bash', 'c', 'cpp', 'css', 'diff', 'go', 'html', 'javascript',
        'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python',
        'query', 'rust', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
      })
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then pcall(vim.treesitter.start, buf) end
      end
    end,
  },

  -- Load all plugin specs from lua/plugins/*.lua
  { import = 'plugins' },

  -- Load user custom plugins from lua/custom/plugins/*.lua
  { import = 'custom.plugins' },

}, {
  ui = { border = 'rounded' },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'matchit', 'matchparen', 'netrwPlugin',
        'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
})
