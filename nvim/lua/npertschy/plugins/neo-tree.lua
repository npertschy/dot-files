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
    { '<leader>pt', '<cmd>Neotree filesystem toggle<CR>', desc = 'NeoTree reveal' },
    { '<leader>pb', '<cmd>Neotree buffers toggle<CR>', desc = 'NeoTree buffers' },
  },
  opts = {
    -- filesystem = {
    --   window = {
    --     mappings = {
    --       ['<leader>pt'] = 'close_window',
    --       ['<leader>pb'] = 'close_window',
    --     },
    --   },
    -- },
  },
}
