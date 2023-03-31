require('treesitter_indent_object').setup()

local function map(key, target, desc) vim.keymap.set({ 'x', 'o' }, key, target, { desc = desc }) end

local obj = require('treesitter_indent_object.textobj')
map('ai', function() obj.select_indent_outer() end, 'Around Indent (line-wise)')
map('aI', function() obj.select_indent_outer(true) end, 'Around Indent (line-wise)')
map('ii', function() obj.select_indent_inner() end, 'Inner Indent (entire range)')
map('iI', function() obj.select_indent_inner(true) end, 'Inner Indent (entire range)')
