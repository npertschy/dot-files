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
  'tsx',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

return {
  {
    'neovim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'neovim-treesitter/treesitter-parser-registry',
      'LiadOz/nvim-dap-repl-highlights',
    },
    config = function()
      require('nvim-dap-repl-highlights').setup()

      -- ── 1. Parser → Filetype Registrierung ──────────────
      -- Nur nötig wo Parser-Name ≠ Filetype
      vim.treesitter.language.register('bash', { 'sh', 'bash', 'zsh' })
      vim.treesitter.language.register('tsx', { 'typescriptreact' })
      vim.treesitter.language.register('javascript', { 'javascriptreact' })
      vim.treesitter.language.register('vimdoc', { 'help' })
      vim.treesitter.language.register('git_config', { 'gitconfig' })
      vim.treesitter.language.register('dap_repl', { 'dap-repl' })

      -- ── 2. Parser installieren ──────────────────────────
      require('nvim-treesitter').install(ensure_installed)

      -- ── 3. Filetypes dynamisch aus Parsern ableiten ─────
      local patterns = {}
      for _, parser in ipairs(ensure_installed) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
          patterns[ft] = true
        end
      end

      -- ── 4. AutoCommand mit korrekten Filetypes ─────────
      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(patterns),
        callback = function(event)
          -- Injection-Parser (luadoc, markdown_inline) werden
          -- automatisch mit gestartet – kein separates Handling nötig
          pcall(vim.treesitter.start, event.buf)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
