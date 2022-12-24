require('treesitter_indent_object').setup()

local function map(key, target) vim.keymap.set({ 'x', 'o' }, key, target) end

local obj = require('treesitter_indent_object.textobj')
map('ai', function() obj.select_indent_outer() end)
map('aI', function() obj.select_indent_outer(true) end)
map('ii', function() obj.select_indent_inner() end)
map('iI', function() obj.select_indent_inner(true) end)
