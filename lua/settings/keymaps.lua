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

local g = vim.g
local o = { remap = false, silent = true } -- opts
local bo = { buffer = true, remap = false, silent = true } -- buffer-local opts

-- plugins
local exchange = require('substitute.exchange')
local luasnip = require('luasnip')
local neogen = require('neogen').generate
local notify = require('notify')
local preview = require('goto-preview')
local substitute = require('substitute')
local telescope = require('telescope')

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
local xmap = function(key, target, opts) map('x', key, target, opts or o) end
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
-- Extended movement & editing
--------------------------------------

-- leap.nvim
nmap('s', '<Plug>(leap-forward-to)', { silent = true })
nmap('S', '<Plug>(leap-backward-to)', { silent = true })
nmap('<space>gs', '<Plug>(leap-cross-window)', { silent = true })

-- substitute.nvim
nmap('<space>s', substitute.operator)
nmap('<space>ss', substitute.line)
nmap('<space>sS', substitute.eol)
xmap('<space>s', substitute.visual)
nmap('X', exchange.operator)
nmap('XX', exchange.line)
xmap('X', exchange.visual)

-- splitjoin
g.splitjoin_split_mapping = '<space>j'
g.splitjoin_join_mapping = '<space>k'
g.splitjoin_python_brackets_on_separate_lines = 1

-- sort.nvim
nmap('<space>SS', '<Cmd>Sort<CR>')
vmap('<space>S', '<Esc><Cmd>Sort<CR>')
nmap('<space>S[', 'vi[<Esc><Cmd>Sort<CR>')
-- {} = ] { }
nmap('<space>S]', 'vi{<Esc><Cmd>Sort<CR>')
nmap('<space>S{', 'vi{<Esc><Cmd>Sort<CR>')
nmap('<space>S}', 'vi{<Esc><Cmd>Sort<CR>')
-- () = 9 0 ( )
nmap('<space>S9', 'vi(<Esc><Cmd>Sort<CR>')
nmap('<space>S0', 'vi(<Esc><Cmd>Sort<CR>')
nmap('<space>S(', 'vi(<Esc><Cmd>Sort<CR>')
nmap('<space>S)', 'vi(<Esc><Cmd>Sort<CR>')
nmap('<space>S"', 'vi"<Esc><Cmd>Sort<CR>')
nmap("<space>S'", "vi'<Esc><Cmd>Sort<CR>")
nmap('<space>Sp', 'vip<Esc><Cmd>Sort<CR>')

-- toggle_words
nmap('<C-T>', '<Cmd>ToggleWord<CR>')
nmap('<C-S-T>', '<Cmd>ToggleWordRev<CR>')

--------------------------------------
-- Code
--------------------------------------

-- LSP
nmap('K', vim.lsp.buf.hover)
nmap('gd', vim.lsp.buf.definition)
nmap('gt', vim.lsp.buf.type_definition)
nmap('gi', vim.lsp.buf.implementation)
nmap('<space>R', '<Cmd>Telescope lsp_references<CR>')
nmap('<space>r', vim.lsp.buf.rename)
nmap('<space>a', vim.lsp.buf.code_action)
nmap(']e', vim.diagnostic.goto_next)
nmap('[e', vim.diagnostic.goto_prev)
nmap('<leader>f', vim.lsp.buf.format)

-- snippets
-- navigate snippets
map({ 'i', 's' }, '<C-j>', function()
  if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, o)
map({ 'i', 's' }, '<C-k>', function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, o)
-- select option from list
map({ 'i', 's' }, '<C-l>', function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end, o)
map({ 'i', 's' }, '<C-h>', function()
  if luasnip.choice_active() then luasnip.change_choice(-1) end
end, o)

-- neogen
nmap('<leader>nc', function() neogen({ type = 'class' }) end)
nmap('<leader>nf', function() neogen({ type = 'func' }) end)
nmap('<leader>nt', function() neogen({ type = 'type' }) end)

-- debugging
local dap = require('dap')
local dapui = require('dapui')
nmap('<F5>', dap.continue)
nmap('<F6>', dap.step_into)
nmap('<F7>', dap.step_over)
nmap('<F8>', dap.step_out)
nmap('<space>db', dap.toggle_breakpoint)
nmap('<space>dB', function() dap.set_breakpoint(vim.fn.input('Break condition: ')) end)
nmap('<leader>du', function() dapui.toggle() end)
vmap('<leader><leader>e', function() dapui.eval() end)

-- trouble
nmap('<leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>')
nmap('<leader>xl', '<Cmd>TroubleToggle loclist<CR>')
nmap('<leader>xq', '<Cmd>TroubleToggle quickfix<CR>')
nmap('<leader>xr', '<Cmd>TroubleToggle lsp_references<CR>')
nmap('<leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>')
nmap('<leader>xx', '<Cmd>TroubleToggle<CR>')

--------------------------------------
-- Build/Execute current file
--------------------------------------

-- code_runner.nvim
nmap('<leader>rr', '<Cmd>RunCode<CR>', { remap = false })
nmap('<leader>rf', '<Cmd>RunFile<CR>', { remap = false })
nmap('<leader>rp', '<Cmd>RunProject<CR>', { remap = false })
nmap('<leader>rc', '<Cmd>RunClose<CR>', { remap = false })

-- sniprun
nvmap('<leader><leader>ee', '<Plug>SnipRun', {})
nvmap('<leader><leader>er', '<Plug>SnipReset', {})
nvmap('<leader><leader>ec', '<Plug>SnipClose', {})

--------------------------------------
-- UI
--------------------------------------
nmap('<leader><leader>f', telescope.extensions.file_browser.file_browser)
nmap('<leader><leader>t', '<Cmd>TagbarToggle<CR>')
nmap('<leader><leader>F', '<Cmd>MaximizerToggle!<CR>')
nmap('<leader><leader>c', notify.dismiss)

--------------------------------------
-- Navigation
--------------------------------------

-- telescope
nmap('<space>ff', '<Cmd>lua Project_files()<CR>')
nmap('<space>fF', '<Cmd>Telescope find_files<CR>')
nmap('<space>fg', '<Cmd>Telescope live_grep<CR>')
nmap('<space>ft', '<Cmd>Telescope tags<CR>')
nmap('<space>fb', '<Cmd>Telescope buffers<CR>')
nmap('<space>fh', '<Cmd>Telescope help_tags<CR>')
nmap('<space>f;', '<Cmd>Telescope command_history<CR>')
nmap('<space>f/', '<Cmd>Telescope search_history<CR>')
nmap('<space>y', '<Cmd>Telescope neoclip<CR>')
-- configs & scripts
local EditConfig = function()
  require('telescope.builtin').find_files({
    search_dirs = { '~/git/dotfiles/config', '~/git/dotfiles/home', '~/git/dotfiles/shells/shared.sh' },
    hidden = true,
  })
end
local EditScript = function() require('telescope.builtin').find_files({ search_dirs = { '~/git/scripts' } }) end
nmap('<space>fc', EditConfig)
nmap('<space>fs', EditScript)

-- any-jump
nmap('g<space>', '<Cmd>AnyJump<CR>')

-- goto-preview
nmap('gpd', preview.goto_preview_definition)
nmap('gpt', preview.goto_preview_type_definition)
nmap('gpi', preview.goto_preview_implementation)
nmap('gpr', preview.goto_preview_references)
nmap('gP', preview.close_all_win)

-- urlview
nmap('<leader><leader>u', '<Cmd>UrlView buffer<CR>')
au( -- Open plugin on github
  'BufRead',
  { pattern = 'plugins.lua', callback = function() nmap('<leader><leader>u', '<Cmd>UrlView packer<CR>', bo) end }
)

--------------------------------------
-- git
--------------------------------------

-- git-fugitive
nvmap('<space>gS', '<Cmd>G<CR>')
nvmap('<leader>gc', '<Cmd>Git commit<CR>')
nvmap('<leader>gp', '<Cmd>Git push<CR>')

--lazygit
nmap('<leader>gg', '<Cmd>LazyGit<CR>')

--------------------------------------
-- Custom commands and Key Bindings
--------------------------------------
-- Reload nvim configs
cmd('Reload', ':source $MYVIMRC', { nargs = 0 })

-- common mistypes
cmd('Q', 'quit<bang>', { nargs = 0 })
cmd('Wq', ':wq', { nargs = 0 })
cmd('Vs', ':vs', { nargs = 0 })
map('c', 'qw', 'wq', { remap = false })

-- Y yanks to end of line
nvmap('Y', 'y$')

-- ctrl-S now saves file
nmap('<C-s>', '<Cmd>w<CR>')
imap('<C-s>', '<Esc><Cmd>w<CR>a')
vmap('<C-s>', '<Esc><Cmd>w<CR>')

-- indent won't deselect
vmap('<', '<gv')
vmap('>', '>gv')

-- move selected stuff up/down
vmap('J', "<Cmd>m '>+1<CR>gv=gv")
vmap('K', "<Cmd>m '>-2<CR>gv=gv")

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
nvmap('<A-h>', '<C-w>h')
nvmap('<A-j>', '<C-w>j')
nvmap('<A-k>', '<C-w>k')
nvmap('<A-l>', '<C-w>l')
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
nvmap('<space>gg', '<Cmd>diffget<CR>')
nvmap('<space>gh', '<Cmd>diffput<CR>')
nvmap('<space>gd', '<Cmd>diffget //2<CR>')
nvmap('<space>gk', '<Cmd>diffget //3<CR>')

-- :terminal
nmap('<A-t>', '<Cmd>terminal<CR>')
tmap('<C-space>', '<C-\\><C-n>')

-- TEST
-- aug experimental
-- au!
--au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- aug end
