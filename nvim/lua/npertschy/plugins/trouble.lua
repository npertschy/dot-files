return {
  'folke/trouble.nvim',
  opts = {
    auto_jump = true,
    modes = {
      diagnostics = {
        preview = {
          type = 'split',
          relative = 'win',
          position = 'right',
          size = 0.6,
        },
      },
      lsp_document_symbols = {
        format = '{access} {kind_icon}{symbol.name} {symbol.detail:Comment}',
      },
    },
    formatters = {
      access = function(ctx)
        local access_icons = { public = '○', protected = '◉', private = '●', export = '○' }
        local symbol = ctx.item.symbol
        local bufnr = ctx.item.buf
        -- ctags provider might add an `access` key
        if symbol and symbol.access then
          return access_icons[symbol.access]
        end

        -- Try to read the line from the buffer and check for access keywords
        if symbol and symbol.selectionRange and symbol.selectionRange.start and symbol.selectionRange.start.line then
          local line = vim.api.nvim_buf_get_lines(bufnr, symbol.selectionRange.start.line, symbol.selectionRange.start.line + 1, false)[1] or ''
          for access, acc_icon in pairs(access_icons) do
            if line:find(access) then
              return acc_icon
            end
          end
        end

        return '  '
      end,
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>x',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics list (Trouble)',
    },
    {
      '<leader>X',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnostics list for current buffer(Trouble)',
    },
    {
      '<leader>o',
      '<cmd>Trouble lsp_document_symbols toggle win.position=right win.size=60<cr>',
      desc = 'Document symbols (Trouble)',
    },
  },
}
