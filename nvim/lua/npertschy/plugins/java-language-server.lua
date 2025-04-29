return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { 'java' },
    opts = function()
      local mason_registry = require 'mason-registry'

      local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()
      local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
      local lombok_path = vim.fs.normalize(jdtls_path .. '/lombok.jar')

      local java_debug_path = mason_registry.get_package('java-debug-adapter'):get_install_path()
      local java_debug = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)

      local java_test_path = mason_registry.get_package('java-test'):get_install_path()

      local bundles = {
        java_debug,
      }
      local all_test_jars = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n')
      local relevant_test_jars = {}
      for _, value in ipairs(all_test_jars) do
        if
          not string.find(value, 'dependencies', 1, true)
          and not string.find(value, 'jacocoagent', 1, true)
          and not string.find(value, 'plugin.jar', 1, true)
        then
          vim.notify(value)
          table.insert(relevant_test_jars, value)
        end
      end

      vim.list_extend(bundles, relevant_test_jars)

      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      local blink_capabilities = require('blink.cmp').get_lsp_capabilities(client_capabilities)

      local jdtls = require 'jdtls'
      local root_dir = jdtls.setup.find_root { 'pom.xml', 'mvnw', 'build.gradle', 'gradlew' }
      local workspace_dir = string.match(jdtls.setup.find_root { '.git' }, '[^/\\]+$')

      local function get_config_dir()
        if vim.fn.has 'linux' == 1 then
          return 'config_linux'
        elseif vim.fn.has 'mac' == 1 then
          return 'config_mac'
        else
          return 'config_win'
        end
      end

      return {
        capabilities = blink_capabilities,
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1G',
          '-javaagent:' .. lombok_path,
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          '-jar',
          launcher_jar,
          '-configuration',
          vim.fs.normalize(jdtls_path .. '/' .. get_config_dir()),
          '-data',
          vim.fn.expand '~/.cache/jdtls-workspace/' .. workspace_dir,
        },
        init_options = {
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          bundles = bundles,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
        end,
        root_dir = root_dir,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = 'all',
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require('jdtls').start_or_attach(opts)
    end,
  },
}
