local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

require('treesj').setup({ use_default_keymaps = false })

nmap('<space>k', '<Cmd>TSJJoin<CR>')
nmap('<space>j', '<Cmd>TSJSplit<CR>')
nmap('<space>J', '<Cmd>TSJToggle<CR>')
