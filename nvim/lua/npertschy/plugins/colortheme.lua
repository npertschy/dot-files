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
      },
      options = {
        cursorline = true,
      },
    }
    vim.cmd 'colorscheme onedark'

    -- Set fzf-lua highlight groups to match onedarkpro
    local function set_fzf_lua_highlights()
      local groups = {
        FzfLuaNormal = { fg = colors.fg, bg = colors.bg },
        FzfLuaBorder = { fg = colors.fg, bg = colors.bg },
        FzfLuaTitle = { fg = colors.green, bold = true },
        FzfLuaPrompt = { fg = colors.purple, bold = true },
        FzfLuaPointer = { fg = colors.red },
        FzfLuaMarker = { fg = colors.red },
        FzfLuaSpinner = { fg = colors.yellow },
        FzfLuaHeader = { fg = colors.green },
        FzfLuaInfo = { fg = colors.cyan },
        FzfLuaPreviewNormal = { fg = colors.fg, bg = colors.cursorline },
        FzfLuaPreviewBorder = { fg = colors.fg, bg = colors.cursorline },
        FzfLuaPreviewTitle = { fg = colors.blue, bold = true },
      }
      for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end
    set_fzf_lua_highlights()
  end,
}
