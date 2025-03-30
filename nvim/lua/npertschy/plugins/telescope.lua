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

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'echasnovski/mini.icons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          i = {
            -- ['<c-enter>'] = 'to_fuzzy_refine',
            ['<C-h>'] = 'which_key',
            ['<esc>'] = require('telescope.actions').close,
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
        lsp_references = {
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
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'noice')
    pcall(require('telescope').load_extension, 'frecency')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sp', builtin.git_files, { desc = '[S]earch [P]roject files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', '<cmd>Telescope frecency workspace=CWD<cr>', { desc = '[S]earch [R]ecent files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sm', '<cmd>Telescope noice<cr>', { desc = '[S]earch recent [m]mssages' })
    vim.keymap.set('n', '<leader>sz', builtin.spell_suggest, { desc = '[S]earch spell suggestions' })

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
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
    -- local root_dir = require('jdtls.setup').find_root(root_markers)
    -- if root_dir ~= '' then
    --   vim.keymap.set('n', '<leader>sc', function()
    --     builtin.find_files {
    --       cwd = vim.fn.expand(root_dir .. '/src/main/java'),
    --     }
    --   end, { desc = '[S]earch [C]lasses' })
    --
    --   vim.keymap.set('n', '<leader>st', function()
    --     builtin.find_files {
    --       cwd = vim.fn.expand(root_dir .. '/src/test/java'),
    --     }
    --   end, { desc = '[S]earch [T]ests' })
    --
    --   vim.keymap.set('n', '<leader>sr', function()
    --     builtin.find_files {
    --       cwd = vim.fn.expand(root_dir .. '/src/main/resources'),
    --     }
    --   end, { desc = '[S]earch [R]esources' })
    --
    --   vim.keymap.set('n', '<leader>sR', function()
    --     builtin.find_files {
    --       cwd = vim.fn.expand(root_dir .. '/src/test/resources'),
    --     }
    --   end, { desc = '[S]earch Tests [R]esources' })
    -- end
  end,
}
