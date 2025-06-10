return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup()
  end,
  opts = {
    bundles = {
      autostart_on_load = false,
    },
  },
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
    {
      '<leader>ra',
      '<cmd>OverseerQuickAction<cr>',
      desc = 'Run quick action for last task',
    },
  },
}
