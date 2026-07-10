return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status'

    local trouble = require 'trouble'
    local symbols = trouble.statusline {
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      hl_group = 'lualine_c_normal',
    }

    local color = require 'onedarkpro.helpers'

    local colors = color.get_colors()

    lualine.setup {
      options = {
        theme = 'onedark',
      },
      sections = {
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { symbols.get, cond = symbols.has },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = colors.orange, gui = 'bold' },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
        lualine_y = {
          'lsp_status',
        },
      },
    }
  end,
}
