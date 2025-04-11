return {
  'stevearc/aerial.nvim',
  event = 'VeryLazy',
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  config = function()
    require('aerial').setup()
  end,
  keys = {
    {
      '<leader>o',
      '<cmd>AerialToggle<cr>',
      desc = 'Toggle outline',
    },
  },
}
