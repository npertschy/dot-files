return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  config = function()
    require('fzf-lua').setup {
      actions = {
        files = {
          ['default'] = require('fzf-lua.actions').file_edit,
          ['ctrl-q'] = require('fzf-lua.actions').file_sel_to_qf,
          ['ctrl-y'] = {
            fn = function(selected, _)
              if not selected or not selected[1] then
                return
              end
              vim.fn.setreg('+', selected[1])
              vim.notify('Copied to clipboard: ' .. selected[1], vim.log.levels.INFO)
            end,
            exec_silent = true,
          },
          ['ctrl-v'] = require('fzf-lua.actions').file_vsplit, -- vertical split
          ['ctrl-x'] = require('fzf-lua.actions').file_split, -- horizontal split
        },
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = 'rounded',
        fullscreen = false,
        preview = {
          layout = 'vertical', -- horizontal/vertical auto
          vertical = 'right:60%',
          delay = 0,
        },
        prompt = '>',
        prompt_pos = 'top', -- ensure prompt/input is at the top
      },
      fzf_opts = {
        ['--layout'] = 'reverse', -- ensure input is at the top
        ['--info'] = 'inline',
        ['--height'] = '100%',
        ['--ansi'] = '',
        ['--prompt'] = '> ',
      },
      files = {
        prompt = '[Files]> ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        fd_opts = '--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude build',
        formatter = 'path.filename_first',
        winopts = {
          preview = {
            layout = 'vertical',
            vertical = 'right:60%',
          },
        },
      },
      grep = {
        prompt = '[Grep]> ',
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git/' -g '!node_modules/' -g '!dist/' -g '!build/'",
        formatter = 'path.filename_first',
        winopts = {
          preview = {
            layout = 'vertical',
            vertical = 'right:60%',
          },
        },
      },
      buffers = {
        prompt = '[Buffers]> ',
        sort_lastused = true,
        show_unlisted = true,
        cwd_only = true,
        formatter = 'path.filename_first',
        winopts = {
          preview = {
            layout = 'vertical',
            vertical = 'right:60%',
          },
        },
        actions = {
          ['ctrl-d'] = { fn = require('fzf-lua.actions').buf_del, reload = true },
        },
      },
      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept', -- select all visible, then trigger action
        },
        builtin = {
          ['<C-h>'] = 'toggle-help',
          ['<esc>'] = 'abort',
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },
      git = {
        status = {
          prompt = '[Git Status]> ',
          formatter = 'path.filename_first',
          winopts = {
            preview = {
              layout = 'vertical',
              vertical = 'right:60%',
            },
          },
        },
        files = {
          prompt = '[Git Files]> ',
          formatter = 'path.filename_first',
          winopts = {
            preview = {
              layout = 'vertical',
              vertical = 'right:60%',
            },
          },
        },
      },
      lsp = {
        prompt_postfix = '> ',
        formatter = 'path.filename_first',
        winopts = {
          preview = {
            layout = 'horizontal',
            horizontal = 'down:60%',
          },
        },
        symbols = {
          symbol_width = 120,
          winopts = {
            preview = {
              layout = 'horizontal',
              horizontal = 'down:60%',
            },
          },
        },
        code_actions = {
          prompt = '[LSP Actions]> ',
          previewer = false, -- disable preview for code actions
          winopts = {
            preview = {
              hidden = 'hidden',
            },
          },
        },
        definitions = {
          prompt = '[LSP Definitions]> ',
          winopts = {
            preview = {
              layout = 'horizontal',
              horizontal = 'down:60%',
            },
          },
        },
        references = {
          prompt = '[LSP References]> ',
          winopts = {
            preview = {
              layout = 'horizontal',
              horizontal = 'down:60%',
            },
          },
        },
      },
    }

    local fzf = require 'fzf-lua'
    fzf.register_ui_select(function(fzf_opts, items)
      -- Try to position at cursor for code actions, else center
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      local winopts = { height = h, width = 0.60, row = 0.40 }
      if fzf_opts and fzf_opts.kind == 'codeaction' then
        -- Position at cursor
        local row = (vim.fn.screenrow() - 1) / vim.o.lines
        local col = (vim.fn.screencol() - 1) / vim.o.columns
        -- Clamp to keep window on screen
        row = math.max(0, math.min(row, 0.9))
        col = math.max(0, math.min(col, 0.9))
        winopts = vim.tbl_extend('force', winopts, {
          row = row,
          col = col,
          anchor = 'NW',
        })
      end
      return { winopts = winopts }
    end)

    vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      fzf.files { hidden = true }
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sp', fzf.git_files, { desc = '[S]earch [P]roject files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sm', '<cmd>Noice fzf<cr>', { desc = '[S]earch recent [m]mssages' })
    vim.keymap.set('n', '<leader>sz', fzf.spell_suggest, { desc = '[S]earch spell suggestions' })
    vim.keymap.set('n', '<leader>sC', fzf.git_status, { desc = '[S]earch git [C]hanges' })
    vim.keymap.set('n', '<leader>/', function()
      fzf.blines { prompt = '[/] ', winopts = { preview = { hidden = 'hidden' } } }
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>s/', function()
      fzf.live_grep { grep_open_files = true, prompt = '[S]/ in Open Files' }
    end, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config', follow = true }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
