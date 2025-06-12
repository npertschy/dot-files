return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'rcasia/neotest-java',
      ft = { 'java' },
      dependencies = {
        'mfussenegger/nvim-jdtls',
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
      },
    },
    {
      'marilari88/neotest-vitest',
      keys = {
        {
          'leadertw',
          function()
            require('neotest').run.run { vitestCommand = 'vitest --watch' }
          end,
          desc = 'Run and watch test under cursor',
        },
        {
          '<leader>tW',
          function()
            require('neotest').run.run { vim.fn.expand '%', vitestCommand = 'vitest --watch' }
          end,
          desc = 'Run and watch tests in current file',
        },
      },
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-java' {},
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
          is_test_file = function(file_path)
            return string.match(file_path, 'spec')
          end,
        },
      },
    }
  end,
  keys = {
    {
      '<leader>tr',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run test under cursor',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run last test',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run tests in current file',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Run tests with DAP',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle test summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open {
          enter = true,
          auto_close = true,
        }
      end,
      desc = 'Open test output',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Open test output panel',
    },
  },
}
