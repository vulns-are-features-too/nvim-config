local function nmap(key, target) vim.keymap.set('n', key, target, { silent = true }) end

require('leap').add_default_mappings()

nmap('s', '<Plug>(leap-forward)')
nmap('S', '<Plug>(leap-backward)')
nmap('<space>g<space>', '<Plug>(leap-cross-window)')
