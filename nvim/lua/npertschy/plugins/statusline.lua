return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    config = function()
      local lualine = require 'lualine'
      local lazy_status = require 'lazy.status'

      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'lsp_document_symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }

      lualine.setup {
        options = {
          theme = 'onedark',
        },
        sections = {
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            { symbols.get, cond = symbols.has },
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = '#ff9e64' },
            },
            { 'encoding' },
            { 'fileformat' },
            { 'filetype' },
          },
        },
      }
    end,
  },
  {
    -- replaces incline.nvim
    name = 'winbar',
    dir = vim.fn.stdpath 'config',
    lazy = false,
    config = function()
      local mini_icons = require 'mini.icons'

      local exclude_ft = { 'neo-tree', 'lazy', 'mason', 'help', 'qf', 'trouble', 'snacks_dashboard', 'codecompanion' }

      _G.MyWinbar = function()
        if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
          return ''
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local relpath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':~:.:h')
        local display_path
        if relpath == '' or relpath == '.' then
          display_path = filename
        else
          display_path = string.format('%%#Comment#%s/%%*%s', relpath, filename)
        end

        local ft_icon, ft_hl = mini_icons.get('file', filename)
        local modified = vim.bo[bufnr].modified and '  ●' or ''

        -- diagnostics
        local icons = { error = '󰅚 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' }
        local diag_parts = {}
        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(bufnr, {
            severity = vim.diagnostic.severity[string.upper(severity)],
          })
          if n > 0 then
            table.insert(diag_parts, string.format('%%#DiagnosticSign%s#%s%d ', severity, icon, n))
          end
        end

        local diag_str = table.concat(diag_parts)

        return string.format('%%=%%#%s#%s%%* %s%s %s%%=', ft_hl, ft_icon or '', display_path, modified, diag_str)
      end

      vim.wo.winbar = '%{%v:lua.MyWinbar()%}'

      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter' }, {
        callback = function()
          local win = vim.api.nvim_get_current_win()
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            return
          end

          if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
            vim.wo.winbar = ''
          else
            vim.wo.winbar = '%{%v:lua.MyWinbar()%}'
          end
        end,
      })
    end,
  },
}
