local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, silent = true, desc = desc }) end

local treesj = require('treesj')

treesj.setup({ use_default_keymaps = false, max_join_length = 200 })

nmap('<space>j', treesj.split, 'Split')
nmap('<space>k', treesj.join, 'Join')
nmap('<space>J', function() treesj.toggle({ split = { recursive = true } }) end, 'Join/split recursively')
nmap('<space>K', treesj.toggle, 'Join/split toggle')
