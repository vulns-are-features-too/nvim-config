require('harpoon').setup()
local ui = require('harpoon.ui')
local nmap = function(key, target) vim.keymap.set('n', key, target) end

nmap('<space>m', require('harpoon.mark').add_file)
nmap('<space>gm', ui.toggle_quick_menu)
