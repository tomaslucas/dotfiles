return {
  {
    -- luarocks.nvim bootstraps the `magick` rock that image.nvim needs
    'vhyrro/luarocks.nvim',
    priority = 1001, -- must load before image.nvim
    opts = {
      rocks = { 'magick' },
      hererocks = false, -- use system luarocks instead of building Lua 5.1
    },
  },
  {
    '3rd/image.nvim',
    dependencies = { 'vhyrro/luarocks.nvim' },
    config = function()
      local in_tmux = vim.env.TMUX ~= nil

      require('image').setup {
        backend = 'kitty',

        -- When inside tmux: only render images in the active window and
        -- rely on tmux's `allow-passthrough` to forward kitty graphics
        -- protocol sequences through to the terminal.
        -- (Add `set -g allow-passthrough on` to your tmux.conf if not present.)
        tmux_show_only_in_active_window = in_tmux,

        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' },
          },
          neorg = { enabled = false },
          html = { enabled = false },
          css = { enabled = false },
        },

        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,

        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
        editor_only_render_when_focused = false,
        use_absolute_path = true,
      }
    end,
  },
}
