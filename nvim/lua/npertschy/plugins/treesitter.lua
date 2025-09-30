-- on main branch, treesitter isn't started automatically
vim.api.nvim_create_autocmd({ 'Filetype' }, {
  callback = function(event)
    -- make sure nvim-treesitter is loaded
    local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

    -- no nvim-treesitter, maybe fresh install
    if not ok then
      return
    end

    local ft = vim.bo[event.buf].ft
    local lang = vim.treesitter.language.get_lang(ft)
    nvim_treesitter.install({ lang }):await(function(err)
      if err then
        vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
        return
      end

      pcall(vim.treesitter.start, event.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end)
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
      'LiadOz/nvim-dap-repl-highlights',
    },
    opts = {},
    config = function(_, opts)
      local ensure_installed = {
        'bash',
        'css',
        'dap_repl',
        'diff',
        'gitignore',
        'gitattributes',
        'html',
        'java',
        'javascript',
        'typescript',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'mdx',
        'properties',
        'tsx',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      }

      -- make sure nvim-treesitter can load
      local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

      -- no nvim-treesitter, maybe fresh install
      if not ok then
        return
      end

      require('nvim-dap-repl-highlights').setup()
      nvim_treesitter.install(ensure_installed)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
