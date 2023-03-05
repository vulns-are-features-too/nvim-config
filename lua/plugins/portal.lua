local jl = require('portal.builtin').jumplist
local nmap = function(key, target) vim.keymap.set('n', key, target, {}) end

require('portal').setup({
  labels = { 'j', 'k', 'h', 'l', 'f', 'd', 's', 'g' },
})

nmap('<space>o', jl.tunnel_backward)
nmap('<space>i', jl.tunnel_forward)
