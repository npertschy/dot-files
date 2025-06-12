return {
  'folke/flash.nvim',
  opts = {
    modes = {
      search = {
        enabled = true,
      },
    },
  },
  keys = {
    {
      '<A-s>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      '<A-r>',
      mode = { 'o' },
      function()
        require('flash').remote()
      end,
      desc = 'Flash Remote',
    },
  },
}
