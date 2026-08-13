return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  ft = { 'markdown' },
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' },
  },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
}
