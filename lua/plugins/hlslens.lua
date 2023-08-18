require('hlslens').setup({
  enable_incsearch = true,
  calm_down = false,
  nearest_only = false,
  nearest_float_when = 'never'
})

local function nmap(key, target) vim.keymap.set('n', key, target, { noremap = true, silent = true }) end

nmap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
nmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
nmap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
nmap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
nmap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])
