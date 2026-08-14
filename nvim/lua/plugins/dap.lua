-- Debugger: nvim-dap + dap-ui + virtual text + mason adapters
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- UI
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      -- Virtual text showing variable values inline
      'theHamsta/nvim-dap-virtual-text',
      -- Mason integration for auto-installing debug adapters
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      -- Core
      { '<F5>',       function() require('dap').continue() end,          desc = 'DAP: Continue / Start' },
      { '<F10>',      function() require('dap').step_over() end,         desc = 'DAP: Step Over' },
      { '<F11>',      function() require('dap').step_into() end,         desc = 'DAP: Step Into' },
      { '<F12>',      function() require('dap').step_out() end,          desc = 'DAP: Step Out' },
      -- Breakpoints
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'DAP: Toggle Breakpoint' },
      { '<leader>dB', function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,                                                              desc = 'DAP: Conditional Breakpoint' },
      { '<leader>dl', function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,                                                              desc = 'DAP: Log Point' },
      -- Session
      { '<leader>dr', function() require('dap').repl.open() end,         desc = 'DAP: Open REPL' },
      { '<leader>dR', function() require('dap').run_last() end,          desc = 'DAP: Run Last' },
      { '<leader>dq', function() require('dap').terminate() end,         desc = 'DAP: Terminate' },
      -- UI
      { '<leader>du', function() require('dapui').toggle() end,          desc = 'DAP: Toggle UI' },
      { '<leader>de', function() require('dapui').eval() end,            desc = 'DAP: Eval Expression', mode = { 'n', 'v' } },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- ── Virtual text ────────────────────────────────────────────────────
      require('nvim-dap-virtual-text').setup {
        enabled = true,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      }

      -- ── UI layout ───────────────────────────────────────────────────────
      dapui.setup {
        icons = { expanded = '', collapsed = '', current_frame = '' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        layouts = {
          {
            elements = {
              { id = 'scopes',      size = 0.40 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'stacks',      size = 0.20 },
              { id = 'watches',     size = 0.20 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl',    size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10,
            position = 'bottom',
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5,
          border = 'rounded',
          mappings = { close = { 'q', '<Esc>' } },
        },
      }

      -- Auto-open/close UI with DAP session
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- ── Signs ───────────────────────────────────────────────────────────
      vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DapBreakpoint',          linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint',            { text = '◎', texthl = 'DapLogPoint',            linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DapStopped',             linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected',  { text = '✗', texthl = 'DapBreakpointRejected',  linehl = '', numhl = '' })
    end,
  },

  -- ── Mason adapter installer ──────────────────────────────────────────────
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    opts = {
      -- Adapters to auto-install via Mason
      ensure_installed = {
        'python',      -- debugpy
        'delve',       -- Go
        'codelldb',    -- C / C++ / Rust
        'js-debug-adapter', -- JS / TS
      },
      handlers = {
        -- Use default mason-nvim-dap handlers for most adapters
        function(config) require('mason-nvim-dap').default_setup(config) end,

        -- ── Python (debugpy) ──────────────────────────────────────────────
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python',
            args = { '-m', 'debugpy.adapter' },
          }
          config.configurations = {
            {
              type = 'python',
              request = 'launch',
              name = 'Launch file',
              program = '${file}',
              pythonPath = function()
                local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_DEFAULT_ENV'
                if venv then return venv .. '/bin/python' end
                return vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python'
              end,
            },
            {
              type = 'python',
              request = 'launch',
              name = 'Launch file with arguments',
              program = '${file}',
              args = function()
                local args = vim.fn.input 'Args: '
                return vim.split(args, ' ', { trimempty = true })
              end,
              pythonPath = function()
                return vim.fn.exepath 'python3' or 'python'
              end,
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,

        -- ── Go (delve) ───────────────────────────────────────────────────
        delve = function(config)
          config.configurations = {
            {
              type = 'delve',
              name = 'Debug',
              request = 'launch',
              program = '${file}',
            },
            {
              type = 'delve',
              name = 'Debug Package',
              request = 'launch',
              program = '${fileDirname}',
            },
            {
              type = 'delve',
              name = 'Attach',
              request = 'attach',
              processId = require('dap.utils').pick_process,
            },
            {
              type = 'delve',
              name = 'Debug test',
              request = 'launch',
              mode = 'test',
              program = '${file}',
            },
            {
              type = 'delve',
              name = 'Debug test (package)',
              request = 'launch',
              mode = 'test',
              program = './${relativeFileDirname}',
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,

        -- ── C / C++ (codelldb) ────────────────────────────────────────────
        codelldb = function(config)
          config.configurations = {
            {
              type = 'codelldb',
              name = 'Launch (C/C++)',
              request = 'launch',
              program = function()
                return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
            },
            {
              type = 'codelldb',
              name = 'Attach to process',
              request = 'attach',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
}
