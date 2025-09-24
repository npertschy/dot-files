return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          accept_word = '<M-l>',
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        codecompanion = true,
      },
    },
  },
}
