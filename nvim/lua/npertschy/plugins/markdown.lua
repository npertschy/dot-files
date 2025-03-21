return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  keys = {
    { '<leader>mr', '<cmd>RenderMarkdown<CR>', desc = 'Render markdown' },
    { '<leader>ms', '<cmd>RenderMarkdown disable<CR>', desc = 'Disable markdown rendering' },
  },
}
