require('neogen').setup({ snippet_engine = 'luasnip' })

local gen = require('neogen').generate
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, silent = true, desc = desc }) end

nmap('<leader>nc', function() gen({ type = 'class' }) end, '[N]eogen [C]lass doc comments')
nmap('<leader>nf', function() gen({ type = 'func' }) end, '[N]eogen [F]unction doc comments')
nmap('<leader>nt', function() gen({ type = 'type' }) end, '[N]eogen [T]ype doc comments')
