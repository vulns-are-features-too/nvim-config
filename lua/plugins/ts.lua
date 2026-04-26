local ts = require('nvim-treesitter')

local function nmap(key, target, opts) vim.keymap.set('n', key, target, opts) end
local function nxomap(key, target, opts) vim.keymap.set({ 'n', 'x', 'o' }, key, target, opts) end

local languages = {
  'bash',
  'c',
  'comment',
  'cpp',
  'diff',
  'dockerfile',
  'go',
  'haskell',
  'html',
  'http',
  'java',
  'javascript',
  'jq',
  'json',
  'latex',
  'lua',
  'markdown',
  'markdown_inline',
  'php',
  'python',
  'query',
  'rasi',
  'regex',
  'rust',
  'sql',
  'sxhkdrc',
  'toml',
  'typescript',
  'vim',
  'yaml',
}

---- general ----
vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function()
    vim.treesitter.start()

    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

nmap('<leader>ts', '<Cmd>InspectTree<CR>', { remap = false, silent = true })

ts.install(languages)

-- comment strings
vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup({ enable_autocmd = false })

---- text objects ----

require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V',  -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = false,
  },
})

-- select
local select_textobject = require('nvim-treesitter-textobjects.select').select_textobject
local function map_obj(keys, target)
  vim.keymap.set({ 'x', 'o' }, keys, function() select_textobject(target, 'textobjects') end)
end

map_obj('aB', '@block.outer')
map_obj('iB', '@block.inner')
map_obj('af', '@call.outer')
map_obj('if', '@call.inner')
map_obj('aC', '@class.outer')
map_obj('iC', '@class.inner')
map_obj('aF', '@function.outer')
map_obj('iF', '@function.inner')
map_obj('ac', '@conditional.outer')
map_obj('ic', '@conditional.inner')
map_obj('al', '@loop.outer')
map_obj('il', '@loop.inner')
map_obj('aa', '@parameter.outer')
map_obj('ia', '@parameter.inner')

-- swap
local swap = require('nvim-treesitter-textobjects.swap')
nmap('<space><space>l', function() swap.swap_next('@parameter.inner') end)
nmap('<space><space>h', function() swap.swap_previous('@parameter.inner') end)

-- move
local move = require('nvim-treesitter-textobjects.move')
local function map_move(key, target)
  nxomap(']' .. key, function() move.goto_next_start(target, 'textobjects') end)
  nxomap('[' .. key, function() move.goto_previous_start(target, 'textobjects') end)
end
map_move('C', '@class.outer')
map_move('F', '@function.outer')
map_move('a', '@parameter.outer')
map_move('c', '@conditional.outer')
map_move('f', '@call.outer')
map_move('l', '@loop.outer')

-- Repeat movement
local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
nxomap('f', ts_repeat_move.builtin_f_expr, { expr = true })
nxomap('F', ts_repeat_move.builtin_F_expr, { expr = true })
nxomap('t', ts_repeat_move.builtin_t_expr, { expr = true })
nxomap('T', ts_repeat_move.builtin_T_expr, { expr = true })
nxomap(';', ts_repeat_move.repeat_last_move_next)
nxomap(',', ts_repeat_move.repeat_last_move_previous)
