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
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local sb = require 'spring_boot'
      -- When loaded lazily via `ft`, the FileType event has already fired for the
      -- first buffer, so the autocmd registered by setup() misses it.
      -- Manually start the Spring Boot LSP for the current buffer to compensate.
      local launch = require 'spring_boot.launch'
      local ls_path = sb.get_ls_from_mason()
      if ls_path then
        local boot_opts = vim.tbl_deep_extend('keep', { ls_path = ls_path }, require 'spring_boot.config')
        launch.start(launch.update_ls_config(boot_opts))
      end
    end,
  },
  {
    'alessio-vivaldelli/java-creator-nvim',
    ft = 'java',
    event = 'VeryLazy',
    opts = {
      -- Default configuration
      keymaps = {
        java_new = '<leader>jn',
      },
      options = {
        auto_open = true, -- Open file after creation
        java_version = 21, -- Minimum Java version
        project_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', '.project', 'backend/' },
      },
      default_imports = {},
    },
  },
}
