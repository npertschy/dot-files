return {
  'MeanderingProgrammer/render-markdown.nvim',
  event = 'VeryLazy',
  filetype = { 'markdown', 'mdx', 'codecompanion' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'mdx', 'codecompanion' },
    completions = {
      lsp = { enabled = true },
    },
  },
  keys = {
    { '<leader>mr', '<cmd>RenderMarkdown<CR>', desc = 'Render markdown' },
    { '<leader>ms', '<cmd>RenderMarkdown disable<CR>', desc = 'Disable markdown rendering' },
  },
}
