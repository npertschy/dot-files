return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      bindings = {
        ['s'] = '<cmd>OverseerQuickAction start<cr>',
        ['t'] = 'Stop',
        ['r'] = '<cmd>OverseerQuickAction restart<cr>',
      },
    },
  },
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
      '<M-8>',
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
