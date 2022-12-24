require('neogen').setup({ snippet_engine = 'luasnip' })

local gen = require('neogen').generate
local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

nmap('<leader>nc', function() gen({ type = 'class' }) end)
nmap('<leader>nf', function() gen({ type = 'func' }) end)
nmap('<leader>nt', function() gen({ type = 'type' }) end)
