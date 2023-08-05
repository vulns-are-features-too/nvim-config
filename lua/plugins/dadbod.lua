local function map(mode, key, target, desc) vim.keymap.set(mode, key, target, { expr = true, desc = desc }) end
map('n', '<C-CR>', vim.api.nvim_command('call db#op_exec()'), 'Execute DB query under cursor')
map('v', '<C-CR>', vim.api.nvim_command('call db#op_exec()'), 'Execute selected DB query')
