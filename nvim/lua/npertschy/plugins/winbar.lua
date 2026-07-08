return {
  name = 'winbar',
  dir = vim.fn.stdpath 'config',
  lazy = false,
  config = function()
    local icons = require 'nvim-web-devicons'

    local exclude_ft = {
      'neo-tree',
      'lazy',
      'mason',
      'help',
      'qf',
      'trouble',
      'snacks_dashboard',
      'codecompanion',
      'OverseerList',
      'OverseerOutput',
      'dap-repl',
      'dap-terminal',
      'dap-view',
      'dap-view-term',
      'dap-view-help',
      'dap-view-hover',
      'neotest-summary',
    }

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

      local ft_icon, ft_hl = icons.get_icon(filename, vim.bo[bufnr].filetype, { default = true })
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

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter' }, {
      callback = function()
        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
          return
        end

        if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
          return
        end

        vim.wo.winbar = '%{%v:lua.MyWinbar()%}'
      end,
    })
  end,
}
