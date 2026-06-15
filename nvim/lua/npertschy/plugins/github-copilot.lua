return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'BufReadPost',
    opts = {
      auth_provider_url = 'https://mercedes-benz.ghe.com/',
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<M-L>',
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
