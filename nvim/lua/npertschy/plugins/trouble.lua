return {
  'folke/trouble.nvim',
  opts = {
    modes = {
      diagnostics = {
        preview = {
          type = 'split',
          relative = 'win',
          position = 'right',
          size = 0.6,
        },
      },
      symbols = {
        level = 1,
        filter = {
          ['not'] = { ft = 'lua', kind = 'Package' },
          any = {
            ft = { 'help', 'markdown' },
            kind = {
              'Class',
              'Constant',
              'Constructor',
              'Enum',
              'Field',
              'Function',
              'Interface',
              'Method',
              'Module',
              'Namespace',
              'Package',
              'Property',
              'Struct',
              'Trait',
              'Variable',
            },
          },
        },
      },
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
      '<leader>o',
      '<cmd>Trouble symbols toggle focus=false win.size=80<cr>',
      desc = 'Symbols outline (Trouble)',
    },
    {
      '<leader>q',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix list (Trouble)',
    },
  },
}
