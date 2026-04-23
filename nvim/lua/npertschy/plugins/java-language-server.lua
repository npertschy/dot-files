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
    opts = {},
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
