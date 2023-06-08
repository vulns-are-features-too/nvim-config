require('obsidian').setup({
  dir = '~/sync/obsidian',
  notes_subdir = 'mobile/notes',
  templates = {
    subdir = 'templates',
    date_format = '%Y-%m-%d',
    time_format = '%H:%M',
  },
  use_advanced_uri = true,
  completion = { nvim_cmp = true },
})
