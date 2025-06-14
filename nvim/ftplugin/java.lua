local jdtls_path = vim.fn.expand '$MASON/packages/jdtls'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local lombok_path = vim.fs.normalize(jdtls_path .. '/lombok.jar')

local java_debug_path = vim.fn.expand '$MASON/packages/java-debug-adapter'
local java_debug = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)

local java_test_path = vim.fn.expand '$MASON/packages/java-test'

local bundles = {
  java_debug,
}
local all_test_jars = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n')
local relevant_test_jars = {}
for _, value in ipairs(all_test_jars) do
  if not string.match(value, 'jacoco') and not string.match(value, 'dependencies') then
    table.insert(relevant_test_jars, value)
  end
end

vim.list_extend(bundles, relevant_test_jars)

local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

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

local config = {
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
    vim.fn.expand '$HOME/.cache/jdtls-workspace/' .. workspace_dir,
  },
  init_options = {
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    bundles = bundles,
  },
  on_attach = function(client, bufnr)
    if root_dir ~= '' then
      vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
      vim.keymap.set('n', '<leader>tc', jdtls.test_class, { desc = 'Test class', buffer = bufnr })
      vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, { desc = 'Test method', buffer = bufnr })
      vim.keymap.set('n', '<leader>tp', jdtls.pick_test, { desc = 'Pick and run Test', buffer = bufnr })

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sC', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/main/java'),
        }
      end, { desc = '[S]earch [C]lasses' })

      vim.keymap.set('n', '<leader>sT', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/test/java'),
        }
      end, { desc = '[S]earch [T]ests' })

      vim.keymap.set('n', '<leader>sr', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/main/resources'),
        }
      end, { desc = '[S]earch [R]esources' })

      vim.keymap.set('n', '<leader>sR', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/test/resources'),
        }
      end, { desc = '[S]earch Tests [R]esources' })
    end
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

require('jdtls').start_or_attach(config)
