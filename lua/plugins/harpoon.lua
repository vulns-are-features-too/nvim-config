local harpoon = require('harpoon')

harpoon:setup()

local function nmap(key, target, desc) vim.keymap.set('n', key, target, { desc = desc }) end

local function nav(file)
  return function() harpoon:list():select(file) end
end

nmap('mm', function() harpoon:list():add() end, 'Harpoon add file')
nmap('m/', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'Harpoon menu')
nmap('m,', function() harpoon:list():prev() end, 'Harpoon navigate back')
nmap('m.', function() harpoon:list():next() end, 'Harpoon navigate next')

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

-- basic telescope configuration
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

nmap('<space>fm', function() toggle_telescope(harpoon:list()) end, 'Telescope harpoon marks')
