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
      '<M-f>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
