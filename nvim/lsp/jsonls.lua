return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'json5' },
  init_options = { provideFormatter = true },
  root_markers = { '.git' },
  settings = {
    json = {
      format = {
        enable = true,
      },
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
