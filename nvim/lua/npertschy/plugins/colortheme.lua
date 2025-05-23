return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    local color = require 'onedarkpro.helpers'

    local colors = color.get_colors()

    require('onedarkpro').setup {
      highlights = {
        ['@attribute.java'] = { fg = colors.cyan },
        ['@lsp.type.modifier.java'] = { fg = colors.purple },
        ['@lsp.type.interface.java'] = { fg = colors.green, italic = true },

        DiagnosticUnderlineError = { fg = 'NONE', sp = colors.red, undercurl = true },
        DiagnosticUnderlineWarn = { fg = 'NONE', sp = colors.orange, undercurl = true },
        DiagnosticUnderlineInfo = {fg = 'NONE', sp = colors.green, undercurl = true },
        DiagnosticUnderlineHint = { fg = 'NONE', sp = colors.blue, undercurl = true },

        SpellBad = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellCap = { fg = 'NONE',  sp = colors.cyan, undercurl = true },
        SpellLocal = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellRare = { fg = 'NONE', sp = colors.cyan, undercurl = true },
      },
      options = {
        cursorline = true,
      },
    }
    vim.cmd 'colorscheme onedark'
  end,
}
