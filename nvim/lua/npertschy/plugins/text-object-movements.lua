return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  branch = 'main',
  opts = {},
  keys = function()
    local select = require 'nvim-treesitter-textobjects.select'
    local swap = require 'nvim-treesitter-textobjects.swap'
    local move = require 'nvim-treesitter-textobjects.move'
    return {
      {
        'a=',
        function()
          select.select_textobject('@assignment.outer', 'textobjects')
        end,
        desc = 'Select outer part of an assignment',
      },
      {
        'i=',
        function()
          select.select_textobject('@assignment.inner', 'textobjects')
        end,
        desc = 'Select inner part of an assignment',
      },
      {
        'l=',
        function()
          select.select_textobject('@assignment.lhs', 'textobjects')
        end,
        desc = 'Select left hand side of an assignment',
      },
      {
        'r=',
        function()
          select.select_textobject('@assignment.rhs', 'textobjects')
        end,
        desc = 'Select right hand side of an assignment',
      },
      {
        'aa',
        function()
          select.select_textobject('@parameter.outer', 'textobjects')
        end,
        desc = 'Select outer part of a parameter/argument',
      },
      {
        'ia',
        function()
          select.select_textobject('@parameter.inner', 'textobjects')
        end,
        desc = 'Select inner part of a parameter/argument',
      },
      {
        'ai',
        function()
          select.select_textobject('@conditional.outer', 'textobjects')
        end,
        desc = 'Select outer part of a conditional',
      },
      {
        'ii',
        function()
          select.select_textobject('@conditional.inner', 'textobjects')
        end,
        desc = 'Select inner part of a conditional',
      },
      {
        'al',
        function()
          select.select_textobject('@loop.outer', 'textobjects')
        end,
        desc = 'Select outer part of a loop',
      },
      {
        'il',
        function()
          select.select_textobject('@loop.inner', 'textobjects')
        end,
        desc = 'Select inner part of a loop',
      },
      {
        'af',
        function()
          select.select_textobject('@call.outer', 'textobjects')
        end,
        desc = 'Select outer part of a function call',
      },
      {
        'if',
        function()
          select.select_textobject('@call.inner', 'textobjects')
        end,
        desc = 'Select inner part of a function call',
      },
      {
        'am',
        function()
          select.select_textobject('@function.outer', 'textobjects')
        end,
        desc = 'Select outer part of a method/function definition',
      },
      {
        'im',
        function()
          select.select_textobject('@function.inner', 'textobjects')
        end,
        desc = 'Select inner part of a method/function definition',
      },
      {
        'ac',
        function()
          select.select_textobject('@class.outer', 'textobjects')
        end,
        desc = 'Select outer part of a class',
      },
      {
        'ic',
        function()
          select.select_textobject('@class.inner', 'textobjects')
        end,
        desc = 'Select inner part of a class',
      },
      {
        '<leader>cna',
        function()
          swap.swap_next('@parameter.inner', 'textobjects')
        end,
        desc = 'Swap parameter/argument with next',
      },
      {
        '<leader>cn:',
        function()
          swap.swap_next('@property.outer', 'textobjects')
        end,
        desc = 'Swap object property with next',
      },
      {
        '<leader>cnm',
        function()
          swap.swap_next('@function.outer', 'textobjects')
        end,
        desc = 'Swap function with next',
      },
      {
        '<leader>cpa',
        function()
          swap.swap_previous('@parameter.inner', 'textobjects')
        end,
        desc = 'Swap parameter/argument with previous',
      },
      {
        '<leader>cp:',
        function()
          swap.swap_previous('@property.outer', 'textobjects')
        end,
        desc = 'Swap object property with previous',
      },
      {
        '<leader>cpm',
        function()
          swap.swap_previous('@function.outer', 'textobjects')
        end,
        desc = 'Swap function with previous',
      },
      {
        ']f',
        function()
          move.goto_next_start('@call.outer', 'textobjects')
        end,
        desc = 'Next function call start',
      },
      {
        ']m',
        function()
          move.goto_next_start('@function.outer', 'textobjects')
        end,
        desc = 'Next method/function def start',
      },
      {
        ']c',
        function()
          move.goto_next_start('@class.outer', 'textobjects')
        end,
        desc = 'Next class start',
      },
      {
        ']i',
        function()
          move.goto_next_start('@conditional.outer', 'textobjects')
        end,
        desc = 'Next conditional start',
      },
      {
        ']l',
        function()
          move.goto_next_start('@loop.outer', 'textobjects')
        end,
        desc = 'Next loop start',
      },
      {
        '[f',
        function()
          move.goto_previous_start('@call.outer', 'textobjects')
        end,
        desc = 'Prev function call start',
      },
      {
        '[m',
        function()
          move.goto_previous_start('@function.outer', 'textobjects')
        end,
        desc = 'Prev method/function def start',
      },
      {
        '[c',
        function()
          move.goto_previous_start('@class.outer', 'textobjects')
        end,
        desc = 'Prev class start',
      },
      {
        '[i',
        function()
          move.goto_previous_start('@conditional.outer', 'textobjects')
        end,
        desc = 'Prev conditional start',
      },
      {
        '[l',
        function()
          move.goto_previous_start('@loop.outer', 'textobjects')
        end,
        desc = 'Prev loop start',
      },
      {
        ']F',
        function()
          move.goto_next_end('@call.outer', 'textobjects')
        end,
        desc = 'Next function call end',
      },
      {
        ']M',
        function()
          move.goto_next_end('@function.outer', 'textobjects')
        end,
        desc = 'Next method/function def end',
      },
      {
        ']C',
        function()
          move.goto_next_end('@class.outer', 'textobjects')
        end,
        desc = 'Next class end',
      },
      {
        ']I',
        function()
          move.goto_next_end('@conditional.outer', 'textobjects')
        end,
        desc = 'Next conditional end',
      },
      {
        ']L',
        function()
          move.goto_next_end('@loop.outer', 'textobjects')
        end,
        desc = 'Next loop end',
      },
      {
        '[F',
        function()
          move.goto_previous_end('@call.outer', 'textobjects')
        end,
        desc = 'Prev function call end',
      },
      {
        '[M',
        function()
          move.goto_previous_end('@function.outer', 'textobjects')
        end,
        desc = 'Prev method/function def end',
      },
      {
        '[C',
        function()
          move.goto_previous_end('@class.outer', 'textobjects')
        end,
        desc = 'Prev class end',
      },
      {
        '[I',
        function()
          move.goto_previous_end('@conditional.outer', 'textobjects')
        end,
        desc = 'Prev conditional end',
      },
      {
        '[L',
        function()
          move.goto_previous_end('@loop.outer', 'textobjects')
        end,
        desc = 'Prev loop end',
      },
    }
  end,
  config = function(_, opts)
    require('nvim-treesitter-textobjects').setup(opts)
  end,
}
