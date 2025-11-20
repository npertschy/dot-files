return {
  'yelog/i18n.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
  opts = {
    i18n_keys = {
      popup_type = 'telescope',
    },
    locales = { 'en' },
    sources = {
      'frontend/src/locales/{locales}/translation.json',
    },
  },
  keys = {
    {
      'gK',
      function()
        require('i18n').i18n_definition()
      end,
      desc = 'Goto translation key',
    },
  },
}
