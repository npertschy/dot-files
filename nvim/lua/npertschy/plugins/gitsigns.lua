return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal { ']h', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end)

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal { '[h', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end)

      -- Git Blame for file or line
      map('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [b]lame file' })
      map('n', '<leader>gl', gitsigns.blame_line, { desc = '[G]it blame [l]ine' })
      map('n', '<leader>gh', gitsigns.preview_hunk, { desc = '[G]it preview [h]unk' })
    end,
  },
}
