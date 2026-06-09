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
        DiagnosticUnderlineInfo = { fg = 'NONE', sp = colors.green, undercurl = true },
        DiagnosticUnderlineHint = { fg = 'NONE', sp = colors.blue, undercurl = true },

        SpellBad = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellCap = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellLocal = { fg = 'NONE', sp = colors.cyan, undercurl = true },
        SpellRare = { fg = 'NONE', sp = colors.cyan, undercurl = true },

        TelescopePromptTitle = { fg = colors.bg, bg = colors.orange, bold = true },
        TelescopeResultsTitle = { fg = colors.bg, bg = colors.blue, bold = true },
        TelescopePreviewTitle = { fg = colors.bg, bg = colors.green, bold = true },
        TelescopePromptBorder = { fg = colors.orange },
        TelescopeResultsBorder = { fg = colors.blue },
        TelescopePreviewBorder = { fg = colors.green },
        TelescopeSelection = { fg = 'NONE' },
        TelescopeSelectionCaret = { fg = colors.yellow, bold = true },
        TelescopeMatching = { fg = colors.yellow, bold = true },
        TelescopePromptCounter = { fg = colors.orange, bold = true },
        TelescopePromptPrefix = { fg = colors.orange, bold = true },

        TelescopeNormal = { bg = colors.bg },
        TelescopePromptNormal = { bg = colors.bg },
        TelescopeResultsNormal = { bg = colors.bg },
        TelescopePreviewNormal = { bg = colors.bg },

        TroubleNormal = { bg = colors.bg },
        TroubleNormalNC = { bg = colors.bg },
        TelescopeResultsFunction = { fg = colors.blue },
        TelescopeResultsMethod = { fg = colors.cyan },
        TelescopeResultsClass = { fg = colors.green },
      },
      options = {
        cursorline = true,
      },
    }
    vim.cmd 'colorscheme onedark_vivid'
  end,
}
