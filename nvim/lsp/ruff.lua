return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'requirements.txt', '.git' },
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.disableOrganizeImports = true
  end,
}
