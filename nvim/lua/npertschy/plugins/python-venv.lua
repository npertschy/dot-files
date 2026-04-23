return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    { 'ibhagwan/fzf-lua' }, -- switched from telescope.nvim to fzf-lua
  },
  ft = 'python', -- Load when opening Python files
  opts = {
    options = {}, -- plugin-wide options
    search = {}, -- custom search definitions
  },
}
