return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[B]reakpoint [C]ondition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle [b]reakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = '[C]ontinue / Run',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to [C]ursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = '[G]oto Line (No Execute)',
      },
      {
        '<M-Down>',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into (↓)',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = '[j] Stack Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = '[k] Stack Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run [L]ast',
      },
      {
        '<M-Up>',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out (↑)',
      },
      {
        '<M-Right>',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over (→)',
      },
      {
        '<leader>dP',
        function()
          require('dap').pause()
        end,
        desc = '[P]ause',
      },
      {
        '<leader>dS',
        function()
          require('dap').session()
        end,
        desc = '[S]ession',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = '[T]erminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = '[W]idgets',
      },
      {
        '<leader>td',
        '<cmd>DapViewToggle!<cr>',
        desc = '[D]AP view toggle',
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
              cwd = function()
                return vim.fn.getcwd() .. '/src'
              end,
              sourceMaps = true,
              resolveSourceMapLocations = function()
                return { vim.fn.getcwd() .. '/**', '!**/node_modules/**' }
              end,
              skipFiles = function()
                return { vim.fn.getcwd() .. '/node_modules/**/*.js' }
              end,
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

      dap.listeners.before['event_exited']['clear_qflist'] = function(_, body)
        if body and body.exitCode == 0 then
          vim.fn.setqflist({}, 'r', { title = 'Test Results', items = {} })
          require('trouble').close()
        end
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
        sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
        default_section = 'console',
      },
      windows = {
        terminal = {
          position = 'right',
        },
      },
      auto_toggle = true,
      virtual_text = {
        enabled = true,
      },
    },
  },
}
