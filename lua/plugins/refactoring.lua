local refactoring = require('refactoring')

local function ref(inp)
  return function() refactoring.refactor(inp) end
end

local function map(mode, key, target, desc)
  vim.keymap.set(mode, key, ref(target), { remap = false, silent = true, desc = desc })
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

map('v', '<space>re', 'Extract Function', '[Refactor] Extract function')
map('v', '<space>rf', 'Extract Function To File', '[Refactor] Extract function to file')
map('v', '<space>rv', 'Extract Variable', '[Refactor] Extract variable')
map('n', '<space>re', 'Extract Block', '[Refactor] Extract block')
map('n', '<space>rf', 'Extract Block To File', '[Refactor] Extract block to file')
map({ 'n', 'v' }, '<space>ri', 'Inline Variable', '[Refactor] Inline variable')
