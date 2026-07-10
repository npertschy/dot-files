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
        ['@lsp.type.decorator.java'] = { fg = colors.cyan },
        ['@lsp.type.interface.java'] = { fg = colors.green, italic = true },

        DiagnosticUnderlineError = { fg = 'NONE', sp = colors.red, undercurl = true },
        DiagnosticUnderlineWarn = { fg = 'NONE', sp = colors.orange, undercurl = true },
        DiagnosticUnderlineInfo = { fg = 'NONE', sp = colors.green, undercurl = true },
        DiagnosticUnderlineHint = { fg = 'NONE', sp = colors.blue, undercurl = true },

        SpellBad = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellCap = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellLocal = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellRare = { fg = 'NONE', sp = colors.cyan, undercurl = true },

        FzfLuaTitle = { fg = colors.bg, bg = colors.orange, bold = true },
        FzfLuaBorder = { fg = colors.blue },
        FzfLuaPreviewTitle = { fg = colors.bg, bg = colors.green, bold = true },
        FzfLuaPreviewBorder = { fg = colors.green },
        FzfLuaCursorLine = { fg = 'NONE' },
        FzfLuaCursorLineNr = { fg = colors.purple, bold = true },
        FzfLuaFzfMatch = { fg = colors.purple, bold = true },
        FzfLuaFzfPrompt = { fg = colors.orange, bold = true },
        FzfLuaFzfInfo = { fg = colors.orange, bold = true },
        FzfLuaNormal = { bg = colors.bg },
        FzfLuaPreviewNormal = { bg = colors.bg },

        TroubleNormal = { bg = colors.bg },
        TroubleNormalNC = { bg = colors.bg },

        NeotestDir = { fg = colors.cyan },
        NeotestFile = { fg = colors.blue },
        NeotestNamespace = { fg = colors.green },
        NeotestTest = { fg = colors.white },
      },
      options = {
        cursorline = true,
      },
    }
    vim.cmd 'colorscheme onedark_vivid'
  end,
}
