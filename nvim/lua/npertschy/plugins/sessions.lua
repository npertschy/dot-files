return {
  'stevearc/resession.nvim',
  event = 'VimEnter',
  opts = {
    extensions = {
      overseer = {},
    },
  },
  keys = {
    {
      '<leader>wd',
      function()
        require('resession').delete()
      end,
      desc = 'Delete session',
    },
    {
      '<leader>wr',
      function()
        require('resession').load()
      end,
      desc = 'Restore session for cwd',
    },
    {
      '<leader>ws',
      function()
        require('resession').save()
      end,
      desc = 'Save session for auto session root dir',
    },
  },
  config = function(_, opts)
    local resession = require 'resession'
    resession.setup(opts)

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        resession.save(vim.fn.getcwd())
      end,
    })
  end,
}
