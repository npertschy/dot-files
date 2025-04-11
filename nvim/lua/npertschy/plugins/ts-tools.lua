return {
  {
    'yioneko/nvim-vtsls',
    lazy = true,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    lazy = true,
    config = function()
      require('ts-error-translator').setup {
        auto_override_publish_diagnostics = true,
      }
    end,
  },
}
