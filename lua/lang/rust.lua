vim.b.dispatch = 'cargo build'
vim.opt_local.tags = './rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi'
vim.cmd([[silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!]])
