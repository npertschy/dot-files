return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local fzf = require 'fzf-lua'
      local actions = require 'fzf-lua.actions'

      local function copy_selected(selected)
        if selected and selected[1] then
          local entry = selected[1]:match '[^:]+:%d+:%d+:(.+)' or selected[1]:match '[^:]+:%d+:(.+)' or selected[1]
          vim.fn.setreg('+', entry)
          vim.notify('Copied to clipboard: ' .. entry, vim.log.levels.INFO)
        end
      end

      fzf.setup {
        'default-title',
        fzf_opts = {
          ['--layout'] = 'reverse',
          ['--cycle'] = true,
        },
        keymap = {
          builtin = {
            ['<C-h>'] = 'toggle-help',
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
          },
          fzf = {
            ['ctrl-q'] = 'select-all+accept',
            ['esc'] = 'abort',
          },
        },
        actions = {
          files = {
            ['enter'] = actions.file_edit_or_qf,
            ['ctrl-s'] = actions.file_split,
            ['ctrl-v'] = actions.file_vsplit,
            ['ctrl-t'] = actions.file_tabedit,
            ['ctrl-y'] = { fn = copy_selected, exec_silent = true },
          },
          buffers = {
            ['enter'] = actions.buf_edit,
            ['ctrl-x'] = { fn = actions.buf_del, reload = true },
            ['ctrl-y'] = { fn = copy_selected, exec_silent = true },
          },
        },
        defaults = {
          formatter = 'path.filename_first',
        },
        winopts = {
          height = 0.85,
          width = 0.85,
          preview = {
            horizontal = 'right:60%',
            layout = 'horizontal',
          },
        },
        files = {
          fd_opts = '--type f --hidden --exclude .git --exclude node_modules --exclude dist --exclude build',
        },
        grep = {
          rg_opts = '--column --line-number --no-heading --color=always --smart-case --hidden -g "!node_modules" -g "!.git/" -g "!dist/" -g "!build/"',
        },
        lsp = {
          includeDeclaration = false,
          winopts = {
            preview = {
              layout = 'horizontal',
              horizontal = 'down:60%',
            },
          },
          code_actions = {
            previewer = false, -- disable preview for code actions
            winopts = {
              preview = {
                hidden = 'hidden',
              },
            },
          },
        },
      }

      fzf.register_ui_select {
        winopts = {
          relative = 'cursor',
          row = 1,
          col = 0,
          height = 0.4,
          width = 0.4,
        },
      }

      vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        fzf.files { hidden = true }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sp', fzf.git_files, { desc = '[S]earch [P]roject files' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sm', function()
        require('noice.integrations.fzf').open {
          actions = {
            ['ctrl-y'] = { fn = copy_selected, exec_silent = true },
          },
        }
      end, { desc = '[S]earch recent [m]essages' })
      vim.keymap.set('n', '<leader>sz', fzf.spell_suggest, { desc = '[S]earch spell suggestions' })
      vim.keymap.set('n', '<leader>sc', fzf.git_status, { desc = '[S]earch git [c]hanges' })
      vim.keymap.set('n', '<leader>sl', fzf.resume, { desc = '[S]earch with [L]ast picker' })

      vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        fzf.live_grep { grep_open_files = true, prompt = 'Live Grep in Open Files> ' }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        fzf.files { cwd = vim.fn.stdpath 'config', follow = true }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
