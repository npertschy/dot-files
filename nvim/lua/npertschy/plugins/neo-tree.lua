vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.icons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<M-1>', '<cmd>Neotree filesystem reveal<CR>', desc = 'NeoTree reveal filesystem' },
    { '<M-2>', '<cmd>Neotree buffers reveal<CR>', desc = 'NeoTree reveal buffers' },
  },
  opts = {
    filesystem = {
      group_empty_dirs = true,
      window = {
        mappings = {
          ['<M-1>'] = 'close_window',
        },
      },
    },
    buffers = {
      window = {
        mappings = {
          ['<M-2>'] = 'close_window',
        },
      },
    },
  },
}
