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
vim.list_extend(bundles, all_test_jars)

vim.list_extend(bundles, require('spring_boot').java_extensions())

local blink_capabilities = require('blink.cmp').get_lsp_capabilities()
local root_dir = vim.fs.root(0, { 'pom.xml', 'mvnw', 'build.gradle', 'gradlew' })
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
  capabilities = blink_capabilities,
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4G',
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
      vim.keymap.set('n', '<leader>tc', jdtls.test_class, { desc = 'Test class', buffer = bufnr })
      vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, { desc = 'Test method', buffer = bufnr })
      vim.keymap.set('n', '<leader>tp', jdtls.pick_test, { desc = 'Pick and run Test', buffer = bufnr })
      vim.keymap.set('n', '<leader>tg', require('jdtls.tests').goto_subjects, { desc = 'Goto subject', buffer = bufnr })

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

      vim.keymap.set('n', '<leader>jf', '<cmd>JdtCompile full<cr>', { desc = 'Compile full project' })
      vim.keymap.set('n', '<leader>ji', '<cmd>JdtCompile incremental<cr>', { desc = 'Complile incremental' })
    end

    vim.lsp.codelens.refresh()

    -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.java' },
      callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
      end,
    })
  end,
  root_dir = root_dir,
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.Matchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
        },
        importOrder = {
          'com',
          'org',
          'javax',
          'java',
        },
      },
    },
  },
}

require('jdtls').start_or_attach(config)
