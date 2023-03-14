local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end
local treesj = require('treesj')

treesj.setup({ use_default_keymaps = false, max_join_length = 200 })

nmap('<space>j', treesj.split)
nmap('<space>k', treesj.join)
nmap('<space>J', function() treesj.toggle({ split = { recursive = true } }) end)
nmap('<space>K', treesj.toggle)
