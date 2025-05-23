return {
  'MeanderingProgrammer/render-markdown.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  keys = {
    { '<leader>mr', '<cmd>RenderMarkdown<CR>', desc = 'Render markdown' },
    { '<leader>ms', '<cmd>RenderMarkdown disable<CR>', desc = 'Disable markdown rendering' },
  },
}
