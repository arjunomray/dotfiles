-- Autoformatting with conform.nvim
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      { '<leader>cf', function() require('conform').format { async = true, lsp_format = 'fallback' } end, mode = { 'n', 'v' }, desc = 'Format Buffer' },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable lsp fallback for languages with strict clang-format style
        local no_lsp = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_format = no_lsp[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
      formatters_by_ft = {
        lua        = { 'stylua' },
        python     = { 'isort', 'black' },
        javascript = { 'prettierd', stop_after_first = true },
        typescript = { 'prettierd', stop_after_first = true },
        json       = { 'prettierd' },
        yaml       = { 'prettierd' },
        markdown   = { 'prettierd' },
        css        = { 'prettierd' },
        html       = { 'prettierd' },
      },
    },
  },
}
