local function snack_selector()
  local fzf = require 'fzf-lua'
  local builtin = require 'fzf-lua.previewer.builtin'

  local ScratchPreviewer = builtin.buffer_or_file:extend()

  local function open_picker()
    local entries = Snacks.scratch.list()

    ---@type table<string, table>
    local lookup = {}
    local display = {}

    for _, entry in ipairs(entries) do
      local label = string.format('%s %s \t %s %s', entry.icon, entry.name, entry.branch, entry.cwd)
      lookup[label] = entry
      table.insert(display, label)
    end

    function ScratchPreviewer:new(o, opts, fzf_win)
      ScratchPreviewer.super.new(self, o, opts, fzf_win)
      setmetatable(self, ScratchPreviewer)
      return self
    end

    function ScratchPreviewer:parse_entry(entry_str)
      local entry = lookup[entry_str]
      if not entry then
        return {}
      end
      return { path = entry.file, line = 1, col = 1 }
    end

    fzf.fzf_exec(display, {
      prompt = 'Scratch> ',
      previewer = ScratchPreviewer,
      actions = {
        ['default'] = function(selected)
          local entry = lookup[selected[1]]
          Snacks.scratch.open { icon = entry.icon, file = entry.file, name = entry.name, ft = entry.ft }
        end,
        ['ctrl-x'] = function(selected)
          local entry = lookup[selected[1]]
          vim.fn.delete(entry.file)
          vim.schedule(open_picker)
        end,
      },
    })
  end

  open_picker()
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
      config = function(opts)
        local mason_action = {
          icon = ' ',
          desc = 'Mason',
          key = 'M',
          action = ':Mason',
        }
        table.insert(opts.preset.keys, 6, mason_action)
      end,
    },
    indent = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scratch = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    {
      '<leader>wu',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<M-t>',
      function()
        Snacks.terminal()
      end,
      desc = '[T]oggle [T]erminal',
      mode = { 'n', 't' },
    },
    {
      '<M-g>',
      function()
        Snacks.lazygit()
      end,
      desc = '[T]oggle [L]azygit',
    },
    {
      '<leader>no',
      function()
        Snacks.scratch()
      end,
      desc = 'Open Scratch Buffer',
    },
    {
      '<leader>ns',
      function()
        snack_selector()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
}
