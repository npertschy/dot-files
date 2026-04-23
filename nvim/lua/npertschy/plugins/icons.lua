return {
  -- {
  --   'nvim-tree/nvim-web-devicons',
  --   commit = '6e76c5e47e957fbf080b1fdac165c66dbd2e7cfb',
  --   opts = {},
  -- },
  {
    'nvim-mini/mini.icons',
    version = '*',
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
