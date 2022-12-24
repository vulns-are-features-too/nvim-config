local substitute = require('substitute')
local exchange = require('substitute.exchange')
local map = function(mode, key, target) vim.keymap.set(mode, key, target, { remap = false, silent = true }) end

substitute.setup({})

map('n', '<space>s', substitute.operator)
map('n', '<space>ss', substitute.line)
map('n', '<space>sS', substitute.eol)
map('x', '<space>s', substitute.visual)
map('n', 'X', exchange.operator)
map('n', 'XX', exchange.line)
map('x', 'X', exchange.visual)
