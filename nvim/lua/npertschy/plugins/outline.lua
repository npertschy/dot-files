return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    symbols = {
      icon_fetcher = function(kind, bufnr, symbol)
        local access_icons = { public = '○', protected = '◉', private = '●', export = '○' }
        local icon = require('outline.config').o.symbols.icons[kind].icon
        -- ctags provider might add an `access` key
        if symbol and symbol.access then
          vim.notify 'Exit early'
          return icon .. ' ' .. access_icons[symbol.access]
        end

        -- Try to read the line from the buffer and check for access keywords
        if symbol and symbol.range and symbol.range.start and symbol.range.start.line then
          local line = vim.api.nvim_buf_get_lines(bufnr, symbol.range.start.line, symbol.range.start.line + 1, false)[1] or ''
          for access, acc_icon in pairs(access_icons) do
            if line:find(access) then
              return acc_icon .. ' ' .. icon
            end
          end
        end

        return '  ' .. icon
      end,
    },
    auto_jump = true,
  },
}
