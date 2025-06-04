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
    { '<leader>pt', '<cmd>Neotree filesystem reveal<CR>', desc = 'NeoTree reveal filesystem' },
    { '<leader>pT', '<cmd>Neotree filesystem toggle<CR>', desc = 'NeoTree toggle filesystem' },
    { '<leader>pb', '<cmd>Neotree buffers reveal<CR>', desc = 'NeoTree reveal buffers' },
    { '<leader>pB', '<cmd>Neotree buffers toggle<CR>', desc = 'NeoTree toggle buffers' },
  },
  opts = {
    filesystem = {
      group_empty_dirs = true,
      window = {
        mappings = {
          ['<leader>pt'] = 'close_window',
          ['<leader>pb'] = 'close_window',
        },
      },
    },
  },
}
