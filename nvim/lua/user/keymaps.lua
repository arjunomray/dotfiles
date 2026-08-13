local map = vim.keymap.set

-- Better defaults
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', 'x', '"_x')              -- don't yank single char deletes
map('n', '<C-d>', '<C-d>zz')      -- keep cursor centred when scrolling
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')            -- keep cursor centred on search
map('n', 'N', 'Nzzzv')

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })

-- Window resize
map('n', '<C-Up>',    '<cmd>resize +2<CR>',          { desc = 'Increase window height' })
map('n', '<C-Down>',  '<cmd>resize -2<CR>',          { desc = 'Decrease window height' })
map('n', '<C-Left>',  '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer nav
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>',     { desc = 'Next buffer' })

-- Better indenting in visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<CR>==',        { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<CR>==',        { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv",        { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv",        { desc = 'Move selection up' })

-- Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix diagnostics' })
map('n', ']d', vim.diagnostic.goto_next,          { desc = 'Next diagnostic' })
map('n', '[d', vim.diagnostic.goto_prev,          { desc = 'Prev diagnostic' })

-- Terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('yank-highlight', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
