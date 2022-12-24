local map = function(key, target) vim.keymap.set({'n','v'}, key, target, { remap = false, silent = true }) end
local g = vim.g
g.tmux_navigator_no_mappings = 1
g.tmux_navigator_disable_when_zoomed = 1
g.tmux_navigator_preserve_zoom = 1

map('<A-h>', '<Cmd>TmuxNavigateLeft<cr>')
map('<A-j>', '<Cmd>TmuxNavigateDown<cr>')
map('<A-k>', '<Cmd>TmuxNavigateUp<cr>')
map('<A-l>', '<Cmd>TmuxNavigateRight<cr>')
