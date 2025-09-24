return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<M-g>',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Copilot Chat',
      mode = { 'n', 'v' },
    },
    {
      '<M-a>',
      '<cmd>CodeCompanionActions<cr>',
      desc = 'Copilot Chat Actions',
      mode = { 'n', 'v' },
    },
  },
}
