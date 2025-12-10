return {
  'bloznelis/buftrack.nvim',
  events = { 'BufEnter' },
  config = function()
    local buftrack = require 'buftrack'
    buftrack.setup()

    -- this will move the current buffer to the top of the buffer list.
    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
      callback = buftrack.track_buffer,
    })

    vim.keymap.set('n', '[b', buftrack.prev_buffer)
    vim.keymap.set('n', ']b', buftrack.next_buffer)
  end,
}
