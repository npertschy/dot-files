return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} }, -- NOTE: Must be loaded before dependants
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto t[y]pe [D]efinition')
        map('<leader>cr', vim.lsp.buf.rename, '[R]ename')
        map('<M-CR>', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
        filetypes = { 'lua' },
      },
      vtsls = {
        settings = {
          complete_functions_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_language_server_path,
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
              preferences = {
                importModuleSpecifier = 'non-relative',
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      },
      vue_ls = {
        settings = {
          hybrid_mode = true,
        },
      },
      eslint = {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
      },
      groovyls = {
        cmd = { 'java', '-jar', vim.fn.stdpath 'data' .. '/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar' },
        filetypes = { 'groovy', 'Jenkinsfile' },
      },
      jsonls = {
        settings = {
          json = {
            format = {
              enable = true,
            },
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
        filetypes = { 'json' },
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
        filetypes = { 'yaml' },
      },
      jdtls = {},
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'eslint',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for server_name, server in pairs(servers) do
      if server_name ~= 'jdtls' then
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        server.on_attach = function(client, bufnr)
          if server_name == 'vtsls' then
            vim.keymap.set('n', '<leader>co', '<CMD>VtsExec organize_imports<CR>', { buffer = bufnr, desc = '[O]rganize Imports' })
          end
        end
        vim.lsp.config(server_name, {
          filetypes = server.filetypes,
          settings = {
            [server_name] = server.settings or {},
          },
        })
        require('mason-lspconfig').setup {
          automatic_enable = true,
          ensure_installed = { server_name },
        }
      end
    end
  end,
}
