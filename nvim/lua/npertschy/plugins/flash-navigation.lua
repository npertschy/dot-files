return {
  'folke/flash.nvim',
  lazy = true,
  opts = {},
  keys = {
    {
      '<A-s>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
