local ensure_installed = {
  'bash',
  'css',
  'dap_repl',
  'diff',
  'git_config',
  'gitignore',
  'gitattributes',
  'html',
  'java',
  'javascript',
  'typescript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'properties',
  'python',
'regex',
  'tsx',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

local patterns = {}
for _, parser in ipairs(ensure_installed) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
    patterns[ft] = true
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(patterns),
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldlevel = 99
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'LiadOz/nvim-dap-repl-highlights',
    },
    config = function()
      local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

      -- no nvim-treesitter, maybe fresh install
      if not ok then
        return
      end
      require('nvim-dap-repl-highlights').setup()

      vim.treesitter.language.register('bash', { 'sh', 'bash', 'zsh' })
      vim.treesitter.language.register('tsx', { 'typescriptreact' })
      vim.treesitter.language.register('javascript', { 'javascriptreact' })
      vim.treesitter.language.register('vimdoc', { 'help' })
      vim.treesitter.language.register('git_config', { 'gitconfig' })
      vim.treesitter.language.register('dap_repl', { 'dap-repl' })
      vim.treesitter.language.register('json', { 'jsonc' })

      nvim_treesitter.install(ensure_installed)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
