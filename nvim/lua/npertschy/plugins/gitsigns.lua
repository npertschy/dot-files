return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    numhl = true,
    word_diff = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text_pos = 'right_align',
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
      map('n', '<leader>gh', gitsigns.preview_hunk_inline, { desc = '[G]it preview [h]unk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [r]eset hunk' })
    end,
  },
}
