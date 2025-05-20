return {
  'stevearc/aerial.nvim',
  event = 'VeryLazy',
  opts = {
    filter_kind = false,
  },
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  keys = {
    {
      '<leader>o',
      '<cmd>AerialToggle<cr>',
      desc = 'Toggle outline',
    },
  },
}
