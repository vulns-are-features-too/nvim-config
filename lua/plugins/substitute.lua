local substitute = require('substitute')
local exchange = require('substitute.exchange')
local function map(mode, key, target, desc)
  vim.keymap.set(mode, key, target, { remap = false, silent = true, desc = desc })
end

substitute.setup({})

map('n', '<space>s', substitute.operator, 'Substitue operator')
map('n', '<space>ss', substitute.line, 'Substitue line')
map('n', '<space>sS', substitute.eol, 'Substitue til EOL')
map('x', '<space>s', substitute.visual, 'Substitue visual selection')
map('n', '<space>x', exchange.operator, 'Exchange operator')
map('n', '<space>xx', exchange.line, 'Exchange line')
map('x', '<space>x', exchange.visual, 'Exchange visual selection')
