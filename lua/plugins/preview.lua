local p = require('goto-preview')
local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

require('goto-preview').setup()

nmap('gpd', p.goto_preview_definition)
nmap('gpt', p.goto_preview_type_definition)
nmap('gpi', p.goto_preview_implementation)
nmap('gpr', p.goto_preview_references)
nmap('gP', p.close_all_win)
