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
    -- ...existing code...
    config = function()
      local sb = require 'spring_boot'
      local ls_path = sb.get_ls_from_mason()
      if ls_path then
        -- setup() registers the FileType autocmd for all subsequent buffers
        sb.setup { ls_path = ls_path }
        -- The FileType event already fired for the first buffer, so trigger manually
        local launch = require 'spring_boot.launch'
        local boot_opts = vim.tbl_deep_extend('keep', { ls_path = ls_path }, require 'spring_boot.config')
        launch.start(launch.update_ls_config(boot_opts))
      end
    end,
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
