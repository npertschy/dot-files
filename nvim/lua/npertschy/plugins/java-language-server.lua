return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
  {
    'JavaHello/spring-boot.nvim',
    ft = { 'java', 'yaml', 'jproperties' },
    dependencies = {
      'mfussenegger/nvim-jdtls',
      'ibhagwan/fzf-lua',
    },
    opts = {
      server = {
        on_init = function(client)
          client.server_capabilities.renameProvider = false
          client.server_capabilities.referencesProvider = false
        end,
      },
    },
  },
  {
    'artur-shaik/jc.nvim',
    ft = { 'java' },
    opts = {
      default_mappings = false,
      map_gf = false,
      on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>jo', '<cmd>JCimportsOrganizeNoSort<cr>', { desc = 'Organize imports', buffer = bufnr })
        vim.keymap.set('n', '<leader>jO', '<cmd>JCimportsOrganizeSmart<cr>', { desc = 'Organize imports (smart)', buffer = bufnr })
        vim.keymap.set('n', '<leader>jn', '<cmd>JCgenerateClass<cr>', { desc = 'Organize imports (smart)', buffer = bufnr })
      end,
    },
  },
}
