return {
  {
    'rcasia/neotest-java',
    -- ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
      'mfussenegger/nvim-dap',
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'neovim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-python',
    },
    config = function()
      local java_adapter = require 'neotest-java' {
        jvm_args = { '-Dliquibase.duplicateFileMode=WARN', '-ea' },
      }
      -- Use jdtls project root to prevent monorepo root detection
      java_adapter.root = function(dir)
        local clients = vim.lsp.get_clients { name = 'jdtls' }
        for _, client in ipairs(clients) do
          local root = client.config.root_dir
          if root and vim.startswith(dir, root) then
            return root
          end
        end
        return nil -- no jdtls client covers this dir → adapter inactive
      end

      require('neotest').setup {
        icons = {
          expanded = '',
          collapsed = '',
          child_indent = ' ',
          child_prefix = ' ',
          final_child_indent = ' ',
          final_child_prefix = ' ',
          passed = '󰄬',
          failed = '󰅙',
          running = '󰑮',
          running_animated = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
          skipped = '󰒭',
          unknown = '',
          watching = '󰈈',
        },
        discovery = {
          filter_dir = function(name)
            local exclude = { 'node_modules', 'target', '.git' }
            for _, v in ipairs(exclude) do
              if name == v then
                return false
              end
            end
            return true
          end,
        },
        adapters = {
          java_adapter,
          require 'neotest-vitest',
          require 'neotest-python',
        },
      }
    end,
    keys = {
      {
        '<leader>rm',
        function()
          require('neotest').output_panel.clear()
          require('neotest').run.run()
        end,
        desc = '[R]un nearest [t]est (neotest)',
      },
      {
        '<leader>rf',
        function()
          require('neotest').output_panel.clear()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[R]un tests in [f]ile (neotest)',
      },
      {
        '<leader>rl',
        function()
          require('neotest').output_panel.clear()
          require('neotest').run.run_last()
        end,
        desc = '[R]un [l]ast test (neotest)',
      },
      {
        '<leader>rd',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = '[R]un test with [d]ebug (neotest)',
      },
      {
        '<M-9>',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle test summary (neotest)',
      },
      {
        '<M-0>',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle test output (neotest)',
      },
    },
  },
}
