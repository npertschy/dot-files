-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- list continuation for markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()

      -- Capture indentation, marker, and trailing content
      local bullet, rest = line:match '^%s*([-*+]%s)(.*)'
      local num, sep, num_rest = line:match '^%s*(%d+)([%.%)])%s(.*)'

      -- Empty bullet item -> exit the list
      if (bullet and rest == '') or (num and num_rest == '') then
        return '<C-u><CR>'
      end

      -- Numbered list (e.g. 1. or 1))
      if num then
        local next_num = tostring(tonumber(num) + 1)
        return '<CR>' .. next_num .. sep .. ' '
      end

      -- Unordered list (-, *, +), respecting indentation
      if bullet then
        return '<CR>' .. bullet
      end

      return '<CR>'
    end, { buffer = true, expr = true })
  end,
})
