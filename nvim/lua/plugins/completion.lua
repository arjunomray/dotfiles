-- Autocompletion: nvim-cmp + luasnip + friendly-snippets
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0) and nil or 'make install_jsregexp',
        dependencies = {
          { 'rafamadriz/friendly-snippets', config = function() require('luasnip.loaders.from_vscode').lazy_load() end },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local cmp     = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>']   = cmp.mapping.select_next_item(),
          ['<C-p>']   = cmp.mapping.select_prev_item(),
          ['<C-b>']   = cmp.mapping.scroll_docs(-4),
          ['<C-f>']   = cmp.mapping.scroll_docs(4),
          ['<C-y>']   = cmp.mapping.confirm { select = true },
          ['<CR>']    = cmp.mapping.confirm { select = true },
          ['<Tab>']   = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer', keyword_length = 4 },
        },
        formatting = {
          format = function(_, item)
            local icons = {
              Text = '󰉿', Method = '󰆧', Function = '󰊕', Constructor = '',
              Field = '󰜢', Variable = '󰀫', Class = '󰠱', Interface = '',
              Module = '', Property = '󰜢', Unit = '󰑭', Value = '󰎠',
              Enum = '', Keyword = '󰌋', Snippet = '', Color = '󰏘',
              File = '󰈙', Reference = '󰈇', Folder = '󰉋', EnumMember = '',
              Constant = '󰏿', Struct = '󰙅', Event = '', Operator = '󰆕',
              TypeParameter = '',
            }
            item.kind = string.format('%s %s', icons[item.kind] or '', item.kind)
            return item
          end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
}
