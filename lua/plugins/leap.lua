local nmap = function(key, target) vim.keymap.set('n', key, target, { silent = true }) end

require('leap').add_default_mappings()

nmap('s', '<Plug>(leap-forward-to)')
nmap('S', '<Plug>(leap-backward-to)')
nmap('<space>g<space>', '<Plug>(leap-cross-window)')
