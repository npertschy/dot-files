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
      '<cmd>OverseerTaskAction<cr>',
      desc = 'Run action on selected task',
    },
  },
  config = function(_, opts)
    local overseer = require 'overseer'
    overseer.setup(opts)

    local npm = require 'overseer.template.npm'
    local root = vim.fn.getcwd()

    for _, pkg_path in ipairs { root .. '/package.json', root .. '/frontend/package.json' } do
      if vim.fn.filereadable(pkg_path) == 1 then
        local dir = vim.fn.fnamemodify(pkg_path, ':h')
        local label = vim.fn.fnamemodify(dir, ':t')

        overseer.register_template {
          name = 'npm: ' .. label,
          generator = function(opts, cb)
            npm.generator(vim.tbl_extend('force', opts, { dir = dir }), cb)
          end,
          condition = {
            callback = function()
              return true
            end,
          },
        }
      end
    end
  end,
}
