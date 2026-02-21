-- render-markdown.nvim: in-buffer markdown rendering with virtual text
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ft = { 'markdown', 'Avante' },
  opts = {
    -- Render headings with bold + concealed symbols
    heading = {
      enabled = true,
      sign = true,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    -- Render code blocks with a subtle background
    code = {
      enabled = true,
      sign = false,
      style = 'full',
      border = 'thin',
    },
    -- Bullet list icons
    bullet = {
      enabled = true,
      icons = { '●', '○', '◆', '◇' },
    },
    -- Checkbox states
    checkbox = {
      enabled = true,
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
    },
    -- Pipe tables rendered with box-drawing chars
    pipe_table = {
      enabled = true,
      style = 'full',
    },
    -- Conceal link URLs in normal mode
    link = {
      enabled = true,
    },
  },
  -- Toggle rendering: <leader>um
  keys = {
    {
      '<leader>um',
      '<cmd>RenderMarkdown toggle<cr>',
      ft = 'markdown',
      desc = '[U]I [M]arkdown render toggle',
    },
  },
}
