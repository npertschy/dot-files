return {
  'echasnovski/mini.icons',
  config = function()
    require('mini.icons').setup()
  end,
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
