local refactoring = require('refactoring')
local o = { remap = false, silent = true }
local nmap = function(key, target) vim.keymap.set('n', key, target, o) end
local vmap = function(key, target) vim.keymap.set('v', key, target, o) end

local function ref(inp)
  return function() refactoring.refactor(inp) end
end

refactoring.setup({
  prompt_func_return_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
  prompt_func_param_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
})

vmap('<space>re', ref('Extract Function'))
vmap('<space>rf', ref('Extract Function To File'))
vmap('<space>rv', ref('Extract Variable'))
vmap('<space>ri', ref('Inline Variable'))
nmap('<space>re', ref('Extract Block'))
nmap('<space>rf', ref('Extract Block To File'))
nmap('<space>ri', ref('Inline Variable'))
