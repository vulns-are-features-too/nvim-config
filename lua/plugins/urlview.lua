require('urlview').setup({
  default_action = 'firefox',
  default_picker = 'telescope',
  default_prefix = 'https://',
  default_title = 'URL:',
  log_level_min = vim.log.levels.INFO,
  sorted = true,
  unique = true,
})
