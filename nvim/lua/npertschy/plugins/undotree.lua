return {
  'jiaoshijie/undotree',
  lazy = true,
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  keys = {
    { '<leader>tu', "<cmd>lua require('undotree').toggle()<cr>", desc = '[T]oggle [u]ndo tree' },
  },
}
