local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

local diff_conf = {
  'diff',
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
}

local filename_conf = { 'filename', file_status = true, path = 1 }

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', diff_conf, 'diagnostics' },
    lualine_c = { filename_conf, 'lsp_progress' },
    lualine_x = { 'filetype' },
    lualine_y = { 'buffers' },
    lualine_z = { 'progress', 'location' },
  },
})
