local function map(keys, target, desc, mode)
  for _, key in ipairs(keys) do
    vim.keymap.set(mode or 'n', key, target, { remap = false, silent = true, desc = desc })
  end
end

require('sort').setup()

map({ '<space>SS' }, '<Cmd>Sort<CR>', 'Sort')
map({ '<space>S' }, '<Esc><Cmd>Sort<CR>', 'Sort selection', 'v')
map({ '<space>S"' }, 'vi"<Esc><Cmd>Sort<CR>', "Sort in 'single quotes")
map({ "<space>S'" }, "vi'<Esc><Cmd>Sort<CR>", 'Sort in "double quotes"')
map({ '<space>Sp' }, 'vip<Esc><Cmd>Sort<CR>', 'Sort in paragraph')
map({ '<space>S[', '<space>S]' }, 'vi{<Esc><Cmd>Sort<CR>', 'Sort in [brackets]')
map({ '<space>S{', '<space>S}' }, 'vi{<Esc><Cmd>Sort<CR>', 'Sort in {braces}')
map({ '<space>S(', '<space>S9', '<space>S0', '<space>S)' }, 'vi(<Esc><Cmd>Sort<CR>', 'Sort in (parenthesis)')
