require('harpoon').setup()
local ui = require('harpoon.ui')
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { desc = desc }) end

nmap("'a", require('harpoon.mark').add_file, 'Harpoon add file')
nmap("'m", ui.toggle_quick_menu, 'Harpoon menu')
nmap("<C-[>", ui.nav_prev, 'Harpoon navigate back')
nmap("<C-]>", ui.nav_next, 'Harpoon navigate next')
