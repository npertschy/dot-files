return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
    },
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Run/Continue',
      },
      {
        '<leader>da',
        function()
          require('dap').continue { before = get_args }
        end,
        desc = 'Run with Args',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to Line (No Execute)',
      },
      {
        '<M-i>',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<M-o>',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<M-p>',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dP',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>dS',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
      {
        '<leader>du',
        '<cmd>DapViewToggle!<cr>',
        desc = 'Dap UI',
      },
    },
    config = function()
      local dap = require 'dap'
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.expand '$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' }

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach',
              processId = require('dap.utils').pick_process,
              cwd = vim.fn.getcwd() .. '/src',
              sourceMaps = true,
              resolveSourceMapLocations = { vim.fn.getcwd() .. '/**', '!**/node_modules/**' },
              skipFiles = { vim.fn.getcwd() .. '/node_modules/**/*.js' },
            },
          }
        end
      end

      dap.configurations['java'] = {
        {
          type = 'java',
          request = 'attach',
          name = 'Debug (Attach) - Remote',
          hostName = '127.0.0.1',
          port = 5005,
        },
      }

      require('nvim-dap-virtual-text').setup {
        commented = true,
        enabled = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
      }

      local dapview = require 'dap-view'
      dap.listeners.before.attach.dapui_config = function()
        dapview.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapview.open()
      end

      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
    end,
  },
  {
    'igorlfs/nvim-dap-view',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        default_section = 'repl',
      },
      windows = {
        terminal = {
          position = 'right',
          start_hidden = false,
        },
      },
    },
  },
}
