return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'BufEnter',
  keys = {
    { '<leader>ce', '<cmd>Refactor extract<CR>', desc = '[C]ode [E]xtract', mode = 'x' },
    { '<leader>cf', '<cmd>Refactor extract_to_file<CR>', desc = '[C]ode Extract to [F]ile', mode = 'x' },
    { '<leader>cv', '<cmd>Refactor extract_var<CR>', desc = '[C]ode Extract [V]ariable', mode = 'x' },
    { '<leader>cV', '<cmd>Refactor inline_var<CR>', desc = '[C]ode Inline [V]ariable', mode = { 'n', 'x' } },
    { '<leader>cM', '<cmd>Refactor inline_func<CR>', desc = '[C]ode Inline [M]ethod', mode = 'n' },
    { '<leader>cm', '<cmd>Refactor extract_block<CR>', desc = '[C]ode Extract [M]ethod', mode = 'n' },
    { '<leader>cF', '<cmd>Refactor extract_block_to_file<CR>', desc = '[C]ode Extract Method to [F]ile', mode = 'n' },
  },
  opts = {},
}
