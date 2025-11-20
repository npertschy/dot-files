return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'ribru17/blink-cmp-spell',
  },
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
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      },
    },

    keymap = {
      preset = 'enter',
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'i18n', 'lsp', 'path', 'snippets', 'buffer', 'spell', 'markdown' },
      providers = {
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        spell = {
          name = 'Spell',
          module = 'blink-cmp-spell',
          opts = {
            -- EXAMPLE: Only enable source in `@spell` captures, and disable it
            -- in `@nospell` captures.
            enable_in_context = function()
              local curpos = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
              local in_spell_capture = false
              for _, cap in ipairs(captures) do
                if cap.capture == 'spell' then
                  in_spell_capture = true
                elseif cap.capture == 'nospell' then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
        buffer = {
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ''
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
        i18n = {
          name = 'i18n',
          module = 'i18n.integration.blink_source',
        },
      },
      per_filetype = {
        codecompanion = { 'codecompanion' },
      },
    },

    signature = { enabled = true },
  },
  opts_extend = {
    'sources.default',
  },
}
