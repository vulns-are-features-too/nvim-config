-- Keeping this config here in case monaqa/dial.nvim becomes good enough to use
-- Filetype-dependent currently doesn't work well (at least not without a bunch of table conversions & extension)
local dm = require('dial.map')
local augend = require('dial.augend')
local function map(mode, key, target, desc) vim.keymap.set(mode, key, target, { noremap = true, desc = desc }) end

local function cycle(elements)
  return augend.constant.new({
    elements = elements,
    word = true,
    cyclic = true,
  })
end

local all_group = {
  augend.integer.alias.decimal_int,
  augend.integer.alias.hex,
  augend.constant.alias.bool,
  augend.date.alias['%d/%m/%Y'],
  cycle({ 'and', 'or' }),
  cycle({ '&&', '||' }),
  cycle({ 'True', 'False' }),
  cycle({ 'TRUE', 'FALSE' }),
  cycle({ 'if', 'else' }),
  cycle({ 'allow', 'deny' }),
  cycle({ 'left', 'right' }),
  cycle({ 'on', 'off' }),
  cycle({ 'enable', 'disable' }),
  cycle({ 'start', 'stop' }),
  cycle({ 'yes', 'no' }),
  cycle({ 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday' }),
  cycle({ 'january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december' }),
}

require('dial.config').augends:register_group({
  default = all_group,
  visual = all_group,

  sh = {
    cycle({ 'if', 'elif', 'else', 'fi' }),
  },
  python = {
    cycle({ 'if', 'elif', 'else' }),
  },
  rust = {
    cycle({ 'Ok', 'Err' }),
  },
  c = {
    cycle({ 'define', 'undef' }),
    cycle({ 'if', 'elif', 'else', 'endif' }),
  },
  cpp = {
    cycle({ 'define', 'undef' }),
  },
  vim = {
    cycle({ 'if', 'else', 'endif' }),
  },
})

map('n', '<C-a>', dm.inc_normal(), 'Dial increment normal')
map('n', '<C-x>', dm.dec_normal(), 'Dial decrement normal')
map('n', 'g<C-a>', dm.inc_gnormal(), 'Dial increment gnormal')
map('n', 'g<C-x>', dm.dec_gnormal(), 'Dial decrement gnormal')
map('v', '<C-a>', dm.inc_visual(), 'Dial increment visual')
map('v', '<C-x>', dm.dec_visual(), 'Dial decrement visual')
map('v', 'g<C-a>', dm.inc_gvisual(), 'Dial increment gvisual')
map('v', 'g<C-x>', dm.dec_gvisual(), 'Dial decrement gvisual')
