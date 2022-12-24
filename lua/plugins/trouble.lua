require('trouble').setup()
local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

nmap('<space>xd', '<Cmd>TroubleToggle document_diagnostics<CR>')
nmap('<space>xl', '<Cmd>TroubleToggle loclist<CR>')
nmap('<space>xq', '<Cmd>TroubleToggle quickfix<CR>')
nmap('<space>xr', '<Cmd>TroubleToggle lsp_references<CR>')
nmap('<space>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>')
nmap('<space>xx', '<Cmd>TroubleToggle<CR>')
