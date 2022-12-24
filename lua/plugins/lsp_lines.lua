LspLineState = false
local l = require('lsp_lines')

local function toggle_lsp_lines()
  l.toggle()
  LspLineState = not LspLineState
  vim.diagnostic.config({ virtual_text = not LspLineState })
end

l.setup()
l.toggle() -- disabled by default
vim.diagnostic.config({ virtual_text = not LspLineState })

vim.keymap.set('n', '<leader>l', toggle_lsp_lines, { desc = 'Toggle lsp_lines' })
