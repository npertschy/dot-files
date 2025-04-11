return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup()
  end,
  keys = {
    {
      '<leader>rr',
      '<cmd>OverseerRun<cr>',
      desc = 'Run command',
    },
    {
      '<leader>rt',
      '<cmd>OverseerToggle<cr>',
      desc = 'View command overview',
    },
  },
}
