local p = require('goto-preview')
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, silent = true ,desc=desc}) end

require('goto-preview').setup()

nmap('gpd', p.goto_preview_definition, 'Goto-preview Definition')
nmap('gpt', p.goto_preview_type_definition, 'Goto-preview Type definition')
nmap('gpi', p.goto_preview_implementation, 'Goto-preview Implementation')
nmap('gpr', p.goto_preview_references, 'Goto-preview References')
nmap('gP', p.close_all_win, 'Goto-preview close')
