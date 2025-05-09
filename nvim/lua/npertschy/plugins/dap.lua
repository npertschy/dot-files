return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
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
        '<leader>di',
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
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dO',
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
        function()
          require('dapui').toggle {}
        end,
        desc = 'Dap UI',
      },
      {
        'wleaderwde',
        function()
          require('dapui').eval()
        end,
        desc = 'Eval',
        mode = { 'n', 'v' },
      },
    },
    config = function()
      local dap = require 'dap'
      -- if not dap.adapters['pwa-node'] then
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          -- 💀 Make sure to update this path to point to your installation
          args = {
            vim.fn.expand '$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }
      -- end
      -- if not dap.adapters['node'] then
      --   dap.adapters['node'] = function(cb, config)
      --     if config.type == 'node' then
      --       config.type = 'pwa-node'
      --     end
      --     local nativeAdapter = dap.adapters['pwa-node']
      --     if type(nativeAdapter) == 'function' then
      --       nativeAdapter(cb, config)
      --     else
      --       cb(nativeAdapter)
      --     end
      --   end
      -- end

      local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' }

      -- local vscode = require 'dap.ext.vscode'
      -- vscode.type_to_filetypes['node'] = js_filetypes
      -- vscode.type_to_filetypes['pwa-node'] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            -- {
            --   type = 'pwa-node',
            --   request = 'launch',
            --   name = 'Launch file',
            --   program = '${file}',
            --   cwd = vim.fn.getcwd(),
            -- },
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

      local dapui = require 'dapui'
      dapui.setup()
      -- dapui.setup {
      --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      --   controls = {
      --     icons = {
      --       pause = '⏸',
      --       play = '▶',
      --       step_into = '⏎',
      --       step_over = '⏭',
      --       step_out = '⏮',
      --       step_back = 'b',
      --       run_last = '▶▶',
      --       terminate = '⏹',
      --       disconnect = '⏏',
      --     },
      --   },
      -- }
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
      --
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

      -- setup dap config by VsCode launch.json file
      -- local vscode = require 'dap.ext.vscode'
      -- local json = require 'plenary.json'
      -- vscode.json_decode = function(str)
      --   return vim.json.decode(json.json_strip_comments(str))
      -- end
    end,
  },
}
