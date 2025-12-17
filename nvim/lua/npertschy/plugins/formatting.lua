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
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true, java = true }
      return {
        timeout_ms = 2500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
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
    },
  },
}
