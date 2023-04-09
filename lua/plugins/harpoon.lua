require('harpoon').setup()
local ui = require('harpoon.ui')
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { desc = desc }) end

local function nav(file)
  return function()
    ui.nav_file(file)
  end
end

nmap('mm', require('harpoon.mark').add_file, 'Harpoon add file')
nmap('m/', ui.toggle_quick_menu, 'Harpoon menu')
nmap('m,', ui.nav_prev, 'Harpoon navigate back')
nmap('m.', ui.nav_next, 'Harpoon navigate next')

-- file mappings based on my split keyboard layout
nmap('m1', nav(1), 'Harpoon nav file 1')
nmap('m2', nav(2), 'Harpoon nav file 2')
nmap('m3', nav(3), 'Harpoon nav file 3')
nmap('m4', nav(4), 'Harpoon nav file 4')
nmap('m5', nav(5), 'Harpoon nav file 5')
nmap('m0', nav(1), 'Harpoon nav file 1')
nmap('m9', nav(2), 'Harpoon nav file 2')
nmap('m8', nav(3), 'Harpoon nav file 3')
nmap('m7', nav(4), 'Harpoon nav file 4')
nmap('m6', nav(5), 'Harpoon nav file 5')
