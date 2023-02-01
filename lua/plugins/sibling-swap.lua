require('sibling-swap').setup({
  use_default_keymaps = true,
  keymaps = {
    ['<space>ll'] = 'swap_with_right',
    ['<space>hh'] = 'swap_with_left',
    ['<space>L'] = 'swap_with_right_with_opp',
    ['<space>H'] = 'swap_with_left_with_opp',
  },
  ignore_injected_langs = false,
})
