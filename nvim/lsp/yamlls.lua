return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { '.git' },
  -- `root_dir` ensures that the LSP does attach to all yaml files not in workflows
  root_dir = function(bufnr, on_dir)
    local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    if not string.find(parent, '/.github') then
      on_dir(parent)
    end
  end,
  settings = {
    yaml = {
      validate = true,
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
