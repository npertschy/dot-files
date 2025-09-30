return {
  'atiladefreitas/dooing',
  config = function()
    require('dooing').setup {
      keymaps = {
        toggle_window = '<leader>N',
        open_project_todo = '<leader>n',
        create_nested_task = 'a',
      },
      window = {
        width = 110,
      },
    }
  end,
}
