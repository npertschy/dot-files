return {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    {
      '<leader>rr',
      '<cmd>OverseerRun<cr>',
      desc = 'Run command',
    },
    {
      '<leader>rp',
      '<cmd>OverseerTaskAction<cr>',
      desc = 'Select task to run',
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
    {
      '<leader>rs',
      '<cmd>OverseerSaveBundle<cr>',
      desc = 'Save task bundle',
    },
    {
      '<leader>rl',
      '<cmd>OverseerLoadBundle!<cr>',
      desc = 'Load task bundle',
    },
    {
      '<leader>rd',
      '<cmd>OverseerDeleteBundle<cr>',
      desc = 'Delete task bundle',
    },
  },
}
