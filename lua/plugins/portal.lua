local jl = require('portal.builtin').jumplist
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { desc = desc }) end

require('portal').setup({
  labels = { 'j', 'k', 'h', 'l', 'f', 'd', 's', 'a', 'g' },
  max_results = 8,
})

nmap('<space>o', jl.tunnel_backward, 'Portal forward')
nmap('<space>i', jl.tunnel_forward, 'Portal forward')
