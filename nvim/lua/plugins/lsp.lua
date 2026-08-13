-- LSP: mason + lspconfig + lazydev
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local pick = function(method)
            return function() Snacks.picker[method]() end
          end

          map('gd',         pick('lsp_definitions'),         'Goto Definition')
          map('gr',         pick('lsp_references'),          'Goto References')
          map('gI',         pick('lsp_implementations'),     'Goto Implementation')
          map('gy',         pick('lsp_type_definitions'),    'Goto Type Definition')
          map('<leader>cs', pick('lsp_document_symbols'),    'Document Symbols')
          map('<leader>cS', pick('lsp_workspace_symbols'),   'Workspace Symbols')
          map('gD',         vim.lsp.buf.declaration,         'Goto Declaration')
          map('K',          vim.lsp.buf.hover,               'Hover Docs')
          map('<leader>ca', vim.lsp.buf.code_action,         'Code Action')
          map('<leader>cr', vim.lsp.buf.rename,              'Rename')

          -- Inlay hints toggle
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end
        end,
      })

      local capabilities = vim.tbl_deep_extend('force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      local servers = {
        clangd  = {},
        gopls   = {},
        pyright = {},
        ts_ls   = {},
        lua_ls  = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()
      require('mason-tool-installer').setup {
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'stylua', 'prettierd', 'black', 'isort' }),
      }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
