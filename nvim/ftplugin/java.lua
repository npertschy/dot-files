local mason_share = vim.fn.expand '$MASON/share'
local jdtls_path = mason_share .. '/jdtls'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher.jar')
local lombok_path = vim.fs.normalize(jdtls_path .. '/lombok.jar')

local java_debug_path = mason_share .. '/java-debug-adapter'
local java_debug = vim.fn.glob(java_debug_path .. '/com.microsoft.java.debug.plugin.jar', true)

local java_test_path = mason_share .. '/java-test'

local bundles = {
  java_debug,
}

local all_test_jars = vim.split(vim.fn.glob(java_test_path .. '/*.jar', true), '\n')
local osgi_test_jars = {}
for _, jar in ipairs(all_test_jars) do
  if not jar:match 'runner%-jar%-with%-dependencies' and not jar:match 'jacocoagent' then
    table.insert(osgi_test_jars, jar)
  end
end

vim.list_extend(bundles, osgi_test_jars)

vim.list_extend(bundles, require('spring_boot').java_extensions())

local root_dir = vim.fs.root(0, { 'mvnw', 'gradlew' })
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local function get_config_dir()
  if vim.fn.has 'linux' == 1 then
    return 'config_linux'
  elseif vim.fn.has 'mac' == 1 then
    return 'config_mac'
  else
    return 'config_win'
  end
end

local jdtls = require 'jdtls'
local extendedClientCapabilities = jdtls.extendedClientCapabilities or {}
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=WARN',
    '-Xmx4G',
    '-Xms512m',
    '-javaagent:' .. lombok_path,
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    launcher_jar,
    '-configuration',
    vim.fn.expand '$MASON/packages/jdtls/' .. get_config_dir(),
    '-data',
    vim.fn.expand '$HOME/.cache/jdtls-workspace/' .. workspace_dir,
  },
  init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
    bundles = bundles,
  },
  on_attach = function(client, bufnr)
    if root_dir ~= '' then
      vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { desc = 'Organize imports', buffer = bufnr })
      vim.keymap.set('n', '<leader>jtc', jdtls.test_class, { desc = 'Test class', buffer = bufnr })
      vim.keymap.set('n', '<leader>jtm', jdtls.test_nearest_method, { desc = 'Test method', buffer = bufnr })
      vim.keymap.set('n', '<leader>jtp', jdtls.pick_test, { desc = 'Pick and run Test', buffer = bufnr })
      vim.keymap.set('n', '<leader>jtg', require('jdtls.tests').goto_subjects, { desc = 'Goto subject', buffer = bufnr })

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>jsc', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/main/java'),
        }
      end, { desc = '[J]ava [s]earch [c]lasses' })

      vim.keymap.set('n', '<leader>jst', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/test/java'),
        }
      end, { desc = '[J]ava [s]earch [t]ests' })

      vim.keymap.set('n', '<leader>jsr', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/main/resources'),
        }
      end, { desc = '[J]ava [s]earch [r]esources' })

      vim.keymap.set('n', '<leader>jsR', function()
        builtin.find_files {
          cwd = vim.fn.expand(root_dir .. '/src/test/resources'),
        }
      end, { desc = '[J]ava [s]earch Tests [R]esources' })

      vim.keymap.set('n', '<leader>jf', '<cmd>JdtCompile full<cr>', { desc = 'Compile full project' })
      vim.keymap.set('n', '<leader>ji', '<cmd>JdtCompile incremental<cr>', { desc = 'Complile incremental' })
    end
  end,
  root_dir = root_dir,
  settings = {
    java = {
      maxConcurrentBuilds = 1,
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      contentProvider = { preferred = 'fernflower' },
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      symbols = {
        includeSourceMethodDeclarations = true,
      },
      completion = {
        enabled = true,
        guessMethodArguments = 'auto',
        favoriteStaticMembers = {
          'org.junit.jupiter.api.Assertions.*',
          'org.assertj.core.api.Assertions.*',
          'org.mockito.Mockito.*',
          'org.mockito.ArgumentMatchers.*',
        },
        importOrder = {
          'com',
          'org',
          'javax',
          'java',
          '',
        },
        chain = {
          enabled = true,
        },
        postfix = {
          enabled = true,
        },
      },
      cleanup = {
        actionsOnSave = {
          'qualifyMembers',
          'qualifyStaticMembers',
          'addOverride',
          'addDeprecated',
          'stringConcatToTextBlock',
          'invertEquals',
          'addFinalModifier',
          'instanceofPatternMatch',
          'lambdaExpression',
          'switchExpression',
        },
      },
    },
  },
}

require('jdtls').start_or_attach(config)
