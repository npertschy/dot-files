return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'lewis6991/async.nvim',
  },
  event = 'BufEnter',
  keys = {
    {
      '<leader>cs',
      function()
        require('refactoring').select_refactor()
      end,
      desc = '[C]ode Inline [V]ariable',
      mode = { 'n', 'x' },
    },
  },
  opts = {},
}
