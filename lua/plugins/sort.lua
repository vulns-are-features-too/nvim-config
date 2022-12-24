local map = function(key, target, mode) vim.keymap.set(mode or 'n', key, target, { remap = false, silent = true }) end

require("sort").setup()

map('<space>SS', '<Cmd>Sort<CR>')
map('<space>S', '<Esc><Cmd>Sort<CR>', 'v')
map('<space>S[', 'vi[<Esc><Cmd>Sort<CR>')
-- {} = ] { }
map('<space>S]', 'vi{<Esc><Cmd>Sort<CR>')
map('<space>S{', 'vi{<Esc><Cmd>Sort<CR>')
map('<space>S}', 'vi{<Esc><Cmd>Sort<CR>')
-- () = 9 0 ( )
map('<space>S9', 'vi(<Esc><Cmd>Sort<CR>')
map('<space>S0', 'vi(<Esc><Cmd>Sort<CR>')
map('<space>S(', 'vi(<Esc><Cmd>Sort<CR>')
map('<space>S)', 'vi(<Esc><Cmd>Sort<CR>')
map('<space>S"', 'vi"<Esc><Cmd>Sort<CR>')
map("<space>S'", "vi'<Esc><Cmd>Sort<CR>")
map('<space>Sp', 'vip<Esc><Cmd>Sort<CR>')

