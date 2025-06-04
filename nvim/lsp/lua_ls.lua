return {
  cmd = {
    'lua-language-server',
  },
  filetypes = { 'lua' },
  root_markers = {
    '.git',
    'lazy-lock.json',
    '.stylua.toml',
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
  single_file_support = true,
}
