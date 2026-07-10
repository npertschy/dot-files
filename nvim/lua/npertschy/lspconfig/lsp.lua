vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable {
  'bashls',
  'eslint',
  'gh_actions_ls',
  'groovyls',
  'jsonls',
  'lua_ls',
  'pyright',
  'ruff',
  'sqls',
  'vtsls',
  'vue_ls',
  'yamlls',
}

vim.diagnostic.config {
  severity_sort = true,
  underline = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local builtin = require 'telescope.builtin'
    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('gy', builtin.lsp_type_definitions, '[G]oto t[y]pe [D]efinition')

    map('gD', function()
      vim.lsp.buf.declaration()
    end, '[G]oto [D]eclaration')

    local symbol_filter = {
      'Class',
      'Constant',
      'Constructor',
      'Enum',
      'Field',
      'Function',
      'Interface',
      'Method',
      'Module',
      'Namespace',
      'Property',
      'Struct',
      'Trait',
    }

    map('<leader>ss', function()
      builtin.lsp_document_symbols { symbols = symbol_filter }
    end, '[S]earch [s]ymbols in document')

    map('<leader>sS', function()
      builtin.lsp_dynamic_workspace_symbols { symbols = symbol_filter }
    end, '[S]earch [S]ymbols in Workspace')

    map('<leader>cr', vim.lsp.buf.rename, '[R]ename')
    map('<M-CR>', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    map('<leader>lr', function()
      local clients = vim.lsp.get_clients()
      vim.ui.select(clients, {
        prompt = 'Welchen LSP-Server möchtest du neu starten?',
        format_item = function(client)
          return client.name
        end,
      }, function(choice)
        if choice then
          local filetypes = choice.config.filetypes or {}
          choice:stop()
          print("LSP '" .. choice.name .. "' wurde gestoppt. Es wird beim nächsten Öffnen eines passenden Buffers neu gestartet.")
          vim.defer_fn(function()
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(bufnr) then
                local ft = vim.bo[bufnr].filetype
                if vim.tbl_contains(filetypes, ft) then
                  vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd 'edit'
                  end)
                end
              end
            end
          end, 100)
        else
          print 'Kein LSP-Server ausgewählt.'
        end
      end)
    end, '[L]SP [R]estart')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local methods = vim.lsp.protocol.Methods
    local bufnr = event.buf
    if client and client:supports_method(methods.textDocument_documentHighlight, bufnr) then
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

    if client and client:supports_method(methods.textDocument_inlayHint, bufnr) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
