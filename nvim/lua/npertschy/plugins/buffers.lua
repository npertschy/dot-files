return {
  'bloznelis/buftrack.nvim',
  config = function()
    local buftrack = require 'buftrack'
    buftrack.setup()

    -- Not required but recommended. Once you start inserting text,
    -- this will move the current buffer to the top of the tracklist.
    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
      callback = buftrack.track_buffer,
    })

    vim.keymap.set('n', '[b', buftrack.prev_buffer, { desc = 'Previous Buffer' })
    vim.keymap.set('n', ']b', buftrack.next_buffer, { desc = 'Next Buffer' })
    vim.keymap.set('n', 'bl', '<CMD>BufTrackList<CR>', { desc = 'Show tracked Buffers' })
  end,
}
