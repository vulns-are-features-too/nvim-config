require('tabout').setup({
  tabkey = '<C-l>',
  backwards_tabkey = '<C-h>',
  act_as_tab = false,
  act_as_shift_tab = false,
  default_tab = '',
  default_shift_tab = '',
  enable_backwards = true,
  completion = false,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' },
  },
  ignore_beginning = true,
  exclude = {}, -- tabout will ignore these filetypes
})
