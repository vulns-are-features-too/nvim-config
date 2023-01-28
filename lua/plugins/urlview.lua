local nmap = function(key, target, opts) vim.keymap.set('n', key, target, opts) end

require('urlview').setup({
  default_action = 'firefox',
  default_picker = 'telescope',
  default_prefix = 'https://',
  default_title = 'URL:',
  log_level_min = vim.log.levels.INFO,
  sorted = true,
  unique = true,
})

nmap('<leader><leader>u', '<Cmd>UrlView buffer<CR>', { remap = false, silent = true })
vim.api.nvim_create_autocmd(-- Open plugin on github
  'BufRead',
  {
    pattern = 'plugins.lua',
    callback = function()
      nmap('<leader><leader>u', '<Cmd>UrlView lazy<CR>', { buffer = true, remap = false, silent = true })
    end,
  }
)
