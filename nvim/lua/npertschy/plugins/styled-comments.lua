return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:?]],
    },
  },
  keys = {
    {
      '<leader>so',
      '<cmd>TodoTelescope<CR>',
      desc = '[S]earch t[o]dos and other comments',
    },
  },
}
