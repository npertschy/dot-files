return {
  'stevearc/overseer.nvim',
  opts = {
    disable_template_modules = {
      'overseer.template.npm',
    },
    task_list = {
      keymaps = {
        ['s'] = 'keymap.run_action',
        ['t'] = { 'keymap.run_action', opts = { action = 'stop' }, desc = 'Stop task' },
        ['r'] = { 'keymap.run_action', opts = { action = 'restart' }, desc = 'Restart task' },
      },
    },
    component_aliases = {
      default = {
        'on_exit_set_status',
        'on_complete_notify',
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
      '<leader>rs',
      '<cmd>OverseerShell<cr>',
      desc = 'Run shell command',
    },
    {
      '<M-8>',
      '<cmd>OverseerToggle<cr>',
      desc = 'Run task overview',
    },
    {
      '<leader>ra',
      '<cmd>OverseerTaskAction<cr>',
      desc = 'Run action on selected task',
    },
  },
}
