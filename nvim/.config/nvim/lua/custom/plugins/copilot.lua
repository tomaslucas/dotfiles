-- GitHub Copilot integration for blink.cmp
-- copilot.lua: Lua-native Copilot plugin (replaces copilot.vim)
-- blink-cmp-copilot: Copilot source for blink.cmp (replaces copilot-cmp which is nvim-cmp only)
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      -- Disable built-in inline suggestion UI; blink.cmp handles display
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = false,
      },
    },
    keys = {
      {
        '<leader>tc',
        '<cmd>Copilot toggle<cr>',
        desc = '[T]oggle [C]opilot',
      },
    },
  },

  -- Extend blink.cmp to add Copilot as a source with lower priority than LSP
  {
    'saghen/blink.cmp',
    dependencies = { 'giuxtaposition/blink-cmp-copilot' },
    opts = {
      sources = {
        -- Append copilot to the default source list
        default = { 'lsp', 'path', 'snippets', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            -- Negative offset keeps Copilot suggestions below LSP items
            score_offset = -100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = 'Copilot'
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
      appearance = {
        kind_icons = { Copilot = '' },
      },
    },
  },
}
