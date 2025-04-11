return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'BufEnter',
  config = function()
    require('refactoring').setup {}

    vim.keymap.set('x', '<leader>ce', ':Refactor extract ', { desc = '[C]ode [E]xtract' })
    vim.keymap.set('x', '<leader>cf', ':Refactor extract_to_file ', { desc = '[C]ode Extract to [F]ile' })

    vim.keymap.set('x', '<leader>cv', ':Refactor extract_var ', { desc = '[C]ode Extract [V]ariable' })

    vim.keymap.set({ 'n', 'x' }, '<leader>cV', ':Refactor inline_var', { desc = '[C]ode Inline [V]ariable' })

    vim.keymap.set('n', '<leader>cM', ':Refactor inline_func', { desc = '[C]ode Inline [M]ethod' })

    vim.keymap.set('n', '<leader>cm', ':Refactor extract_block', { desc = '[C]ode Extract [M]ethod' })
    vim.keymap.set('n', '<leader>cF', ':Refactor extract_block_to_file', { desc = '[C]ode Extract Method to [F]ile' })
  end,
}
