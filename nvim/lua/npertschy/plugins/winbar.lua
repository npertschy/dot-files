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

    -- Collect full paths of buffers currently shown in visible windows
    -- (across all tabpages, so splits/tabs both count for disambiguation).
    local function get_visible_paths()
      local paths = {}
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local name = vim.api.nvim_buf_get_name(buf)
          if name ~= '' then
            table.insert(paths, name)
          end
        end
      end
      return paths
    end

    -- Given the current buffer's full path and a list of all visible paths,
    -- return (filename, relpath) where relpath is nil/'' if the filename is
    -- unique, or the minimal parent-dir suffix needed to disambiguate it.
    local function get_display_parts(full_path, all_paths)
      local parts = vim.split(full_path, '/', { trimempty = true })
      local filename = parts[#parts]

      local others = {}
      for _, p in ipairs(all_paths) do
        if p ~= full_path then
          local oparts = vim.split(p, '/', { trimempty = true })
          if oparts[#oparts] == filename then
            table.insert(others, oparts)
          end
        end
      end

      if #others == 0 then
        return filename, nil
      end

      -- n = number of trailing path segments (including filename) to compare
      local n = 1
      local suffix
      while true do
        n = n + 1
        if n > #parts then
          n = #parts
          break
        end

        suffix = table.concat(vim.list_slice(parts, #parts - n + 1, #parts), '/')

        local unique = true
        for _, oparts in ipairs(others) do
          if #oparts < n then
            unique = false
            break
          end
          local osuffix = table.concat(vim.list_slice(oparts, #oparts - n + 1, #oparts), '/')
          if osuffix == suffix then
            unique = false
            break
          end
        end

        if unique then
          break
        end
      end

      local dir_parts = vim.list_slice(parts, #parts - n + 1, #parts - 1)
      local relpath = table.concat(dir_parts, '/')
      return filename, relpath
    end

    _G.MyWinbar = function()
      if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
        return ''
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local full_path = vim.api.nvim_buf_get_name(bufnr)

      local filename, relpath
      if full_path == '' then
        filename, relpath = '[No Name]', nil
      else
        filename, relpath = get_display_parts(full_path, get_visible_paths())
      end

      local display_path
      if relpath == nil or relpath == '' then
        display_path = filename
      else
        display_path = string.format('%%#Comment#%s/%%*%s', relpath, filename)
      end

      local filetype = vim.bo[bufnr].filetype == 'typescriptreact' and 'tsx' or vim.bo[bufnr].filetype
      local ft_icon, ft_hl = icons.get_icon(filename, filetype, { default = true })
      local modified = vim.bo[bufnr].modified and '  ●' or ''

      -- diagnostics
      local diagnostics_icons = { error = '󰅚 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' }
      local diag_parts = {}
      for severity, icon in pairs(diagnostics_icons) do
        local n = #vim.diagnostic.get(bufnr, {
          severity = vim.diagnostic.severity[string.upper(severity)],
        })
        if n > 0 then
          table.insert(diag_parts, string.format('%%#DiagnosticSign%s#%s%d ', severity, icon, n))
        end
      end

      local diag_str = table.concat(diag_parts)

      return string.format('%%=%%#%s#%s %%*%s%s %s%%=', ft_hl, ft_icon or '', display_path, modified, diag_str)
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
