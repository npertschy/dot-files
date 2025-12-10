vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<M-1>', '<cmd>Neotree filesystem reveal<CR>', desc = 'NeoTree reveal filesystem' },
    { '<M-2>', '<cmd>Neotree buffers reveal<CR>', desc = 'NeoTree reveal buffers' },
  },
  opts = {
    filesystem = {
      group_empty_dirs = true,
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ['<M-1>'] = 'close_window',
        },
      },
    },
    buffers = {
      window = {
        mappings = {
          ['<M-2>'] = 'close_window',
        },
      },
    },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline', 'OverseerList' },
    popup_border_style = '',
  },
  config = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require 'neo-tree.events'
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    require('neo-tree').setup(opts)
  end,
}
