vim.lsp.enable {
  'eslint',
  'groovyls',
  'jsonls',
  'lua_ls',
  'pyright',
  'ruff',
  'vtsls',
  'yamlls',
}

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

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

local function jump_to_lsp_location(method, fallback)
  local params = vim.lsp.util.make_position_params(0, 'utf-8')
  vim.lsp.buf_request(0, method, params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      if fallback then
        fallback()
      end
      return
    end
    local loc = result[1]
    local uri = loc.uri or loc.targetUri
    local range = loc.range or loc.targetSelectionRange
    local filename = vim.uri_to_fname(uri)

    -- Find window with the file open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.api.nvim_buf_get_name(buf) == filename then
        vim.api.nvim_set_current_win(win)
        vim.api.nvim_win_set_cursor(win, { range.start.line + 1, range.start.character })
        return
      end
    end

    -- Fallback: use provided fallback function
    if fallback then
      fallback()
    else
      vim.cmd('edit ' .. filename)
      vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
    end
  end)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', function()
      jump_to_lsp_location('textDocument/definition', require('telescope.builtin').lsp_definitions)
    end, '[G]oto [D]efinition')

    map('gr', function()
      jump_to_lsp_location('textDocument/references', require('telescope.builtin').lsp_references)
    end, '[G]oto [R]eferences')

    map('gI', function()
      jump_to_lsp_location('textDocument/implementation', require('telescope.builtin').lsp_implementations)
    end, '[G]oto [I]mplementation')

    map('gy', function()
      jump_to_lsp_location('textDocument/typeDefinition', require('telescope.builtin').lsp_type_definitions)
    end, '[G]oto t[y]pe [D]efinition')

    map('gD', function()
      jump_to_lsp_location('textDocument/declaration', vim.lsp.buf.declaration)
    end, '[G]oto [D]eclaration')

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
          choice.stop()
          print("LSP '" .. choice.name .. "' wurde gestoppt. Es wird beim nächsten Öffnen eines passenden Buffers neu gestartet.")
          -- Optionally, manually re-attach to all buffers:
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[bufnr].filetype == choice.config.filetype then
              vim.lsp.buf_attach_client(bufnr, choice.id)
            end
          end
        else
          print 'Kein LSP-Server ausgewählt.'
        end
      end)
    end, '[L]SP [R]estart')

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
