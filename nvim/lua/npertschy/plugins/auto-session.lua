local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  return dir:gsub('[^A-Za-z0-9]', '_')
end

return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require 'auto-session'
    local overseer = require 'overseer'

    auto_session.setup {
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/Projects/', '~/Downloads', '~/Documents', '~/Desktop/' },
      pre_save_cmds = {
        function()
          overseer.save_task_bundle(get_cwd_as_name(), nil, { on_conflict = 'overwrite' })
        end,
      },
      pre_restore_cmds = {
        function()
          for _, task in ipairs(overseer.list_tasks {}) do
            task:dispose(true)
          end
        end,
      },
      post_restore_cmds = {
        function()
          overseer.load_task_bundle(get_cwd_as_name(), nil, { ignore_missing = true })
        end,
      },
    }

    local keymap = vim.keymap

    keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' }) -- restore last workspace session for current directory
    keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' }) -- save workspace session for current working directory
  end,
}
