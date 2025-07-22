return {
  'folke/trouble.nvim',
  opts = {
    modes = {
      diagnostics = {
        preview = {
          type = 'split',
          relative = 'win',
          position = 'right',
          size = 0.6,
        },
      },
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>x',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics list (Trouble)',
    },
    {
      '<leader>q',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix list (Trouble)',
    },
  },
}
