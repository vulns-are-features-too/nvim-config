local nvmap = function(key, target) vim.keymap.set({ 'n', 'v' }, key, target) end

nvmap('<leader><leader>ee', '<Plug>SnipRun')
nvmap('<leader><leader>er', '<Plug>SnipReset')
nvmap('<leader><leader>ec', '<Plug>SnipClose')
