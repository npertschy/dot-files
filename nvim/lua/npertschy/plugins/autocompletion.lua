return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'mikavilpas/blink-ripgrep.nvim',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      keymap = {
        preset = 'cmdline',
      },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },
    },

    completion = {
      trigger = {
        prefetch_on_insert = true,
      },
      list = {
        selection = {
          auto_insert = true,
          preselect = true,
        },
      },
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label' }, { 'label_description', gap = 1 } },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights = {}
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then
                  highlights = highlights_info.highlights
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end
                return highlights
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      ghost_text = {
        enabled = true,
        show_with_menu = true,
      },
    },

    keymap = {
      preset = 'enter',
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      sorts = { 'exact', 'score', 'sort_text' },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
      providers = {
        lsp = {
          score_offset = 90,
        },
        path = {
          score_offset = 20,
        },
        snippets = {
          score_offset = 10,
        },
        buffer = {
          score_offset = -10,
        },
        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          opts = {
            backend = {
              use = 'gitgrep-or-ripgrep',
            },
          },
          score_offset = -30,
        },
      },
      per_filetype = {
        codecompanion = { 'codecompanion', 'buffer', 'ripgrep' },
      },
    },

    signature = { enabled = true, window = { border = 'rounded' } },
  },
  opts_extend = {
    'sources.default',
  },
}
