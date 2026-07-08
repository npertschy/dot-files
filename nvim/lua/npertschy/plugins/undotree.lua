return {
  'jiaoshijie/undotree',
  lazy = true,
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  keys = {
    { '<M-u>', "<cmd>lua require('undotree').toggle()<cr>", desc = 'Toggle [u]ndo tree' },
  },
}
