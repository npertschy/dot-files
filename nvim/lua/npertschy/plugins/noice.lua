return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'notify',
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
      cmdline_popup = {
        position = {
          row = -40,
          col = '50%',
        },
      },
      popup = {
        position = {
          row = '50%',
          col = '50%',
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function(_, opts)
    require('telescope').load_extension 'noice'
    require('noice').setup(opts)
  end,
}
