vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.showmode = false
opt.termguicolors = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.wrap = false
opt.list = true
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
opt.fillchars = { fold = ' ', foldopen = '', foldclose = '', foldsep = ' ', diff = '╱', eob = ' ' }

-- Behaviour
opt.mouse = 'a'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 200
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'nosplit'
opt.confirm = true         -- ask instead of fail on unsaved changes
opt.virtualedit = 'block'  -- allow cursor past EOL in visual block

-- Clipboard (deferred so startup is not slowed)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Folding (treesitter-powered, everything open by default)
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = ''
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldminlines = 1
