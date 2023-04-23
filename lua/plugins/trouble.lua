require('trouble').setup()
local function nmap(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

nmap('<space>qd', '<Cmd>TroubleToggle document_diagnostics<CR>')
nmap('<space>ql', '<Cmd>TroubleToggle loclist<CR>')
nmap('<space>qf', '<Cmd>TroubleToggle quickfix<CR>')
nmap('<space>qr', '<Cmd>TroubleToggle lsp_references<CR>')
nmap('<space>qw', '<Cmd>TroubleToggle workspace_diagnostics<CR>')
nmap('<space>qq', '<Cmd>TroubleToggle<CR>')
