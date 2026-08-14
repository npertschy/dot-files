return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      sh = { 'shfmt' },
      lua = { 'stylua' },
      vue = { 'oxfmt', 'prettier', stop_after_first = true },
      css = { 'oxfmt', 'prettier', stop_after_first = true },
      html = { 'oxfmt', 'prettier', stop_after_first = true },
      sql = { 'sql-formatter' },
      typescript = { 'oxfmt', 'prettier', stop_after_first = true },
      markdown = { 'oxfmt', 'prettier', stop_after_first = true },
      xml = { 'xmlformatter' },
    },
    formatters = {
      prettier = {
        options = {
          ft_parsers = {
            typescript = 'typescript',
          },
        },
      },
      ['sql-formatter'] = {
        command = 'sql-formatter',
        args = { '--config', '{ "language": "sql", "tabWidth": 4, "expressionWidth": 200 }' },
      },
    },
  },
}
