return {
  'rmagatti/auto-session',
  opts = {},
  keys = {
    {
      '<leader>wp',
      '<cmd>SessionSearch<CR>',
      desc = 'Pick sessions',
    },
    {
      '<leader>wr',
      '<cmd>SessionRestore<CR>',
      desc = 'Restore session for cwd',
    },
    {
      '<leader>ws',
      '<cmd>SessionSave<CR>',
      desc = 'Save session for auto session root dir',
    },
  },
}
