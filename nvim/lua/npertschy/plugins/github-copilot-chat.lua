return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    lazy = true,
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' },
    },
    -- build = "make tiktoken", -- Only on MacOS or Linux
    keys = {
      {
        '<M-g>',
        '<cmd>CopilotChatToggle<cr>',
        desc = 'Copilot Chat',
      },
    },
    opts = {
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        reset = {
          normal = '<C-l>',
          insert = '<C-l>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle_sticky = {
          detail = 'Makes line under cursor sticky or deletes sticky line.',
          normal = 'gr',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        jump_to_diff = {
          normal = '<M-j>',
        },
        quickfix_diffs = {
          normal = '<M-q>',
        },
        yank_diff = {
          normal = '<M-y>',
          register = '"',
        },
        show_diff = {
          normal = '<M-d>',
        },
        show_system_prompt = {
          normal = '<M-p>',
        },
        show_user_selection = {
          normal = '<M-s>',
        },
      },
    },
  },
}
