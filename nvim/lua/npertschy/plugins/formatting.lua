return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
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
      vue = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      sql = { 'sql-formatter' },
      typescript = { 'prettier' },
      markdown = { 'prettier' },
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
      xmlformatter = {
        command = 'xmlformat',
        args = { '--indent', '4', '-' },
      },
    },
  },
}
