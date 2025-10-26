local function nmap(key, target) vim.keymap.set('n', key, target, { silent = true }) end

nmap('s', '<Plug>(leap-forward)')
nmap('S', '<Plug>(leap-backward)')
nmap('<space>g<space>', '<Plug>(leap-cross-window)')
