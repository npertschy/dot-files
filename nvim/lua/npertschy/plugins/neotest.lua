return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'antoinemadec/FixCursorHold.nvim',
    'neovim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest',
        require 'neotest-python',
      },
    }
  end,
  keys = {
    {
      '<leader>rt',
      function()
        require('neotest').run.run()
      end,
      desc = '[R]un nearest [t]est (neotest)',
    },
    {
      '<leader>rf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[R]un tests in [f]ile (neotest)',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[T]oggle test [s]ummary (neotest)',
    },
  },
}
