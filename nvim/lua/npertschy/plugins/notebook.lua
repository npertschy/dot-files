return {
  'atiladefreitas/dooing',
  config = function()
    require('dooing').setup {
      keymaps = {
        toggle_window = '<leader>nt',
        open_project_todo = '<leader>np',
        create_nesterd_task = '<leader>nc',
      },
    }
  end,
}
