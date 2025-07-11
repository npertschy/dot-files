local function normalize_path(path)
  return path:gsub('\\', '/')
end

local function normalize_cwd()
  return normalize_path(vim.fn.getcwd()) .. '/'
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match '[^/]+$'

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == '' then
    return filename
  end
  return string.format('%s ~ %s', filename, stripped_path)
end

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'echasnovski/mini.icons', enabled = vim.g.have_nerd_font },
    { 'Myzel394/jsonfly.nvim' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-h>'] = 'which_key',
            ['<esc>'] = require('telescope.actions').close,
            ['<C-y>'] = function()
              local actions_state = require 'telescope.actions.state'
              local selected_value = actions_state.get_selected_entry().ordinal
              vim.fn.setreg('+', selected_value)
              vim.notify('Copied to clipboard ' .. selected_value, vim.log.levels.INFO)
            end,
          },
        },
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
          },
        },
        sorting_strategy = 'ascending',
        path_display = path_display,
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<C-d>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
            },
          },
        },
        lsp_references = {
          include_declaration = false,
          trim_text = true,
          fname_width = 120,
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'top',
            mirror = true,
          },
        },
        lsp_definitions = {
          trim_text = true,
          fname_width = 120,
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'top',
            mirror = true,
          },
        },
        spell_suggest = {
          layout_strategy = 'cursor',
          layout_config = {
            prompt_position = 'top',
            height = 0.2,
            width = 0.2,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
            layout_strategy = 'cursor',
            layout_config = {
              prompt_position = 'top',
              height = 0.4,
              width = 0.4,
            },
          },
        },
      },
    }

    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'noice')
    pcall(require('telescope').load_extension, 'frecency')
    pcall(require('telescope').load_extension, 'jsonfly')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sp', builtin.git_files, { desc = '[S]earch [P]roject files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sl', '<cmd>Telescope frecency workspace=CWD<cr>', { desc = '[S]earch [L]atest files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sm', '<cmd>Telescope noice<cr>', { desc = '[S]earch recent [m]mssages' })
    vim.keymap.set('n', '<leader>sz', builtin.spell_suggest, { desc = '[S]earch spell suggestions' })
    vim.keymap.set('n', '<leader>sj', '<cmd>Telescope jsonfly<cr>', { desc = '[S]earch [J]son file' })
    vim.keymap.set('n', '<leader>sc', builtin.git_status, { desc = '[S]earch git [c]hanges' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [r]esumed' })

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
