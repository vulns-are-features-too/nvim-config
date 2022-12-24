require('rest-nvim').setup({
  result_split_horizontal = false,
  result_split_in_place = true,
  skip_ssl_verification = true,
  encode_url = true,
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    show_url = true,
    show_http_info = true,
    show_headers = true,
    formatters = {
      json = 'jq',
      html = function(body) return vim.fn.system({ 'tidy', '-i', '-q', '-' }, body) end,
    },
  },
  jump_to_request = false,
  env_file = '.env',
  custom_dynamic_variables = {},
  yank_dry_run = true,
})

local nmap = function(key, target) vim.keymap.set('n', key, target) end
nmap('<space>ee', '<Plug>RestNvim')
nmap('<space>ep', '<Plug>RestNvimPreview')
nmap('<space>er', '<Plug>RestNvimLast')
