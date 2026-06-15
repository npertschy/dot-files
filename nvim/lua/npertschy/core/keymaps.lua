-- NOTE: leader is space key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- NOTE: navigate to the next specific diagnostic message
vim.keymap.set('n', '<M-D>', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<M-d>', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<M-E>', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to previous [E]rror message' })
vim.keymap.set('n', '<M-e>', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to next [E]rror message' })
vim.keymap.set('n', '<M-W>', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.WARN }
end, { desc = 'Go to previous [W]arn message' })
vim.keymap.set('n', '<M-w>', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.WARN }
end, { desc = 'Go to next [W]arn message' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE disable arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: easy navigation between windows/splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE  move selected line up or down in visual mode
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==gv', { desc = 'Move selected line down' })
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==gv', { desc = 'Move selected line up' })

-- NOTE  move current line up or down in normal mode
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move current line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move current line up' })

-- NOTE: preserve selection when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- NOTE: center the current line when moving up or down, or move through search results
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- NOTE: resize splits and windows
vim.keymap.set('n', '<C-M-l>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window size vertically' })
vim.keymap.set('n', '<C-M-h>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window size vertically' })
vim.keymap.set('n', '<C-M-k>', '<cmd>horizontal resize +2<cr>', { desc = 'Increase window size horizontally' })
vim.keymap.set('n', '<C-M-j>', '<cmd>horizontal resize -2<cr>', { desc = 'Decrease window size horizontally' })

-- NOTE: Paste over currently selected text without yanking it
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste over selection (repeatable)' })

-- NOTE: Toggle diffs for buffers in a split
vim.keymap.set('n', '<leader>tD', function()
  if vim.opt.diff:get() then
    vim.cmd 'diffoff'
  else
    vim.cmd 'windo diffthis'
  end
end, { desc = 'Toggle diff for all windows' })

vim.keymap.set('n', '<M-n>', ']c', { desc = 'Next diff change' })
vim.keymap.set('n', '<M-N>', '[c', { desc = 'Prev diff change' })
