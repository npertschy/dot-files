return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'echasnovski/mini.icons', enabled = vim.g.have_nerd_font },
    { 'Myzel394/jsonfly.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
        path_display = { 'filename_first' },
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
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    }

    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'noice')
    pcall(require('telescope').load_extension, 'jsonfly')
    pcall(require('telescope').load_extension, 'fzf')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sp', builtin.git_files, { desc = '[S]earch [P]roject files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sm', '<cmd>Telescope noice<cr>', { desc = '[S]earch recent [m]mssages' })
    vim.keymap.set('n', '<leader>sz', builtin.spell_suggest, { desc = '[S]earch spell suggestions' })
    vim.keymap.set('n', '<leader>sj', '<cmd>Telescope jsonfly<cr>', { desc = '[S]earch [J]son file' })
    vim.keymap.set('n', '<leader>sC', builtin.git_status, { desc = '[S]earch git [C]hanges' })

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
