--[[ General mapping patterns
<leader><leader>
  UI & project stuff
<C-S-r>
  Reload nvim configs
<leader>f
  Format
<space>d*
  Debug
<leader>g <space>g
  git cmds
--]]

local o = { remap = false, silent = true } -- opts
local bo = { buffer = true, remap = false, silent = true } -- buffer-local opts

--------------------------------------
-- Shorter helper functions
--------------------------------------

-- basic vim commands
local map = vim.keymap.set
local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_user_command

-- basic remapping
local nmap = function(key, target, opts) map('n', key, target, opts or o) end
local vmap = function(key, target, opts) map('v', key, target, opts or o) end
local imap = function(key, target, opts) map('i', key, target, opts or o) end
local tmap = function(key, target, opts) map('t', key, target, opts or o) end
local nvmap = function(key, target, opts) map({ 'n', 'v' }, key, target, opts or o) end
local amap = function(key, target, opts) map({ 'n', 'v', 'i', 'x', 's', 'c', 'o', '!' }, key, target, opts or o) end -- map all modes

--------------------------------------
-- disable mouse
--------------------------------------
amap('<C-ScrollWheelDown>', '<nop>')
amap('<C-ScrollWheelLeft>', '<nop>')
amap('<C-ScrollWheelRight>', '<nop>')
amap('<C-ScrollWheelUp>', '<nop>')
amap('<S-ScrollWheelDown>', '<nop>')
amap('<S-ScrollWheelLeft>', '<nop>')
amap('<S-ScrollWheelRight>', '<nop>')
amap('<S-ScrollWheelUp>', '<nop>')
amap('<ScrollWheelDown>', '<nop>')
amap('<ScrollWheelLeft>', '<nop>')
amap('<ScrollWheelRight>', '<nop>')
amap('<ScrollWheelUp>', '<nop>')
vim.opt.mouse = ''

--------------------------------------
-- Custom commands and Key Bindings
--------------------------------------

function P(i)
  print(vim.inspect(i))
  return i
end

-- Reload nvim configs
cmd('Reload', ':source $MYVIMRC', { nargs = 0 })

-- common mistypes
cmd('Q', 'quit<bang>', { nargs = 0 })
cmd('Wq', ':wq', { nargs = 0 })
cmd('Vs', ':vs', { nargs = 0 })
map('c', 'qw', 'wq', { remap = false })

-- ctrl-S now saves file
nmap('<C-s>', '<Cmd>w<CR>')
nmap('<leader>s', '<Cmd>w<CR>')
imap('<C-s>', '<Esc><Cmd>w<CR>a')
vmap('<C-s>', '<Esc><Cmd>w<CR>')

-- indent won't deselect
vmap('<', '<gv')
vmap('>', '>gv')

-- move selected stuff up/down
vmap('<space>j', "<Cmd>m '>+1<CR>gv=gv")
vmap('<space>k', "<Cmd>m '>-2<CR>gv=gv")

-- closing stuff
nmap('<leader>q', '<Cmd>bd<CR>')

-- replace word under cursor
nmap('<space>R', ':%s/<C-r><C-w>/', { remap = false })

-- nvim configs
aug('nvim_augroup', { clear = true })
au('Filetype', {
  pattern = { 'vim', 'lua' },
  group = 'nvim_augroup',
  callback = function()
    nmap('<C-S-r>', ':source %<CR>', { buffer = true, remap = false })
    imap('<space><space>', '<lt>space>', bo)
    imap('<leader><leader>', '<lt>leader>', bo)
  end,
})

-- go to dir of current file
nmap('gh', '<Cmd>lcd %:p:h<CR>')

-- Text formats
aug('text_augroup', { clear = true })
au('Filetype', {
  pattern = { '', 'markdown', 'plaintex', 'text' },
  group = 'text_augroup',
  callback = function()
    -- undo break points
    imap(',<space>', ',<C-g>u<space>', bo)
    imap('.<space>', '.<C-g>u<space>', bo)
    imap('!<space>', '!<C-g>u<space>', bo)
    imap('?<space>', '?<C-g>u<space>', bo)
    imap(';<space>', ';<C-g>u<space>', bo)
    -- bullets.vim
    imap('<CR>', '<Plug>(bullets-newline)')
    nmap('o', '<Plug>(bullets-newline)')
  end,
})

-- Moving between multiple files/windows
-- nvmap('<A-h>', '<C-w>h')
-- nvmap('<A-j>', '<C-w>j')
-- nvmap('<A-k>', '<C-w>k')
-- nvmap('<A-l>', '<C-w>l')
nvmap('<A-S-h>', '<C-w>H')
nvmap('<A-S-j>', '<C-w>J')
nvmap('<A-S-k>', '<C-w>K')
nvmap('<A-S-l>', '<C-w>L')
nvmap('<A-C-h>', '<C-w><')
nvmap('<A-C-j>', '<C-w>-')
nvmap('<A-C-k>', '<C-w>+')
nvmap('<A-C-l>', '<C-w>>')
nvmap('<A-n>', '<Cmd>next<CR>')
imap('<A-n>', '<Cmd>next<CR>')
nvmap('<A-b>', '<Cmd>previous<CR>')
imap('<A-b>', '<Cmd>previous<CR>')
tmap('<A-h>', '<C-\\><C-N><C-w>h')
tmap('<A-j>', '<C-\\><C-N><C-w>j')
tmap('<A-k>', '<C-\\><C-N><C-w>k')
tmap('<A-l>', '<C-\\><C-N><C-w>l')

-- ctrl-q to quit
nvmap('<A-q>', '<Cmd>q<CR>')
imap('<A-q>', '<Esc>:q<CR>')
nmap('<A-S-q>', ':qa<CR>')

-- <C-y> yanks to system clipboard
nmap('<C-y>', '<Cmd>call setreg("+", getline("."))<CR>')
vmap('<C-y>', '"+y')
-- system keyboard yanks
nmap('<space>y', '"+y')
nmap('yu', '"+yi(')
nmap('y[', '"+yi[')
nmap('y]', '"+yi{')
nmap('y"', '"+yi"')
nmap("y'", [["+yi']])
nmap('y`', '"+yi`')

-- search non-ascii characters (C-/)
nmap('<C-_>', '/[^\\x00-\\x7F]<CR>')

-- <++> as a placeholder
nmap('<space><backspace>', '/<++><CR>ca<')

-- quickfix
nmap('[j', '<Cmd>cnext<CR>')
nmap('[k', '<Cmd>cprev<CR>')
nmap(']j', '<Cmd>lnext<CR>')
nmap(']k', '<Cmd>lprev<CR>')

-- diff
nvmap('<space>go', '<Cmd>diffget<CR>')
nvmap('<space>gp', '<Cmd>diffput<CR>')
nvmap('<space>gf', '<Cmd>diffget //2<CR>')
nvmap('<space>gj', '<Cmd>diffget //3<CR>')

-- git-fugitive
nvmap('<space>gg', '<Cmd>G<CR>')
nvmap('<space>gc', '<Cmd>Git commit<CR>')
nvmap('<leader>gp', '<Cmd>Git push<CR>')

-- :terminal
-- nmap('<A-t>', '<Cmd>terminal<CR>')
tmap('<C-space>', '<C-\\><C-n>')

-- make currect script executable
nmap('<leader>x', '<Cmd>!chmod +x %<CR>')

-- TEST
-- aug experimental
-- au!
--au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- aug end
