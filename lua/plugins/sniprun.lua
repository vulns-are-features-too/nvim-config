local function nvmap(key, target, desc) vim.keymap.set({ 'n', 'v' }, key, target, { desc = desc }) end

nvmap('<leader><leader>ee', '<Plug>SnipRun', 'Execute sniprun')
nvmap('<leader><leader>er', '<Plug>SnipReset', 'Reset sniprun')
nvmap('<leader><leader>ec', '<Plug>SnipClose', 'Close sniprun')
