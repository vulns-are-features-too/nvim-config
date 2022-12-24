require('sibling-swap').setup({
  use_default_keymaps = true,
  keymaps = {
    ['<space>l'] = 'swap_with_right',
    ['<space>h'] = 'swap_with_left',
    ['<space>L'] = 'swap_with_right_with_opp',
    ['<space>H'] = 'swap_with_left_with_opp',
  },
  ignore_injected_langs = false,
})
