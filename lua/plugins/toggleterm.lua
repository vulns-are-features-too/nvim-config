local Terminal = require('toggleterm.terminal').Terminal
local nmap = function(key, target) vim.keymap.set('n', key, target, { noremap = true, silent = true }) end

require('toggleterm').setup({
  open_mapping = '<space>gt',
  hide_numbers = true,
  autochdir = false,
  shade_terminals = false,
  start_in_insert = true,
  direction = 'float',
  close_on_exit = true,
  insert_mappings = false,
})

local lazygit = Terminal:new({ cmd = 'lazygit' })
local _lazygit_toggle = function() lazygit:toggle() end
nmap('<space>gl', _lazygit_toggle)
