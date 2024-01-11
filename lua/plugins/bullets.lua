local g = vim.g
local map = vim.keymap.set

g.bullets_enabled_file_types = { 'markdown' }
g.bullets_set_mappings = false
g.bullets_pad_right = false

map('n', '<space>rn', '<Cmd>RenumberList<CR>', { desc = 'RenumberList' })
map('v', '<space>rn', '<Cmd>RenumberSelection<CR>', { desc = 'RenumberSelection' })
map('i', '<CR>', '<Plug>(bullets-newline)')
map('n', 'o', '<Plug>(bullets-newline)')
