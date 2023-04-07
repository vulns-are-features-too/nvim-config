vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data') .. '/.undodir'

vim.keymap.set('n', '<space>u', vim.cmd.UndotreeToggle)
