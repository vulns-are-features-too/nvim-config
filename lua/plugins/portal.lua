local p = require('portal')
local nmap = function(key, target) vim.keymap.set('n', key, target, {}) end
p.setup({
  query = { 'harpoon', 'modified', 'different', 'valid' },
  labels = { 'j', 'k', 'h', 'l', 'f', 'd', 's', 'g' },
})

nmap('<space>o', p.jump_backward)
nmap('<space>i', p.jump_forward)
