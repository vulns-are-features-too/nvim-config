local luasnip = require('luasnip')
local function map(key, target, desc)
  vim.keymap.set({ 'i', 's' }, key, target, { remap = false, silent = true, desc = desc })
end

require('luasnip.loaders.from_snipmate').lazy_load()
luasnip.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})

-- navigate snippets
map('<C-l>', function()
  if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, 'Next snippet')
map('<C-h>', function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, 'Previous snippet')
-- select option from list
map('<C-S-j>', function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end, 'Next snippet choice')
map('<C-S-k>', function()
  if luasnip.choice_active() then luasnip.change_choice(-1) end
end, 'Previous snippet choice')
