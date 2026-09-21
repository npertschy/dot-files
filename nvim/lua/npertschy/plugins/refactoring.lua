return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'lewis6991/async.nvim',
    },
    keys = {
      {
        '<leader>cs',
        function()
          require('refactoring').select_refactor()
        end,
        desc = '[C]ode refactoring [S]election',
        mode = { 'n', 'x' },
      },
    },
    opts = {},
  },
  {
    'smjonas/inc-rename.nvim',
    opts = {},
    keys = {
      {
        '<leader>cr',
        '<cmd>IncRename<cr>',
        desc = '[C]ode refactoring [R]ename',
      },
    },
  },
}
