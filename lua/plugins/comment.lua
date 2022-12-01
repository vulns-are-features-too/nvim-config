require('Comment').setup({
  toggler = {
    ---Line-comment toggle keymap
    line = '<space>cc',
    ---Block-comment toggle keymap
    block = '<space>bc',
  },

  opleader = {
    ---Line-comment keymap
    line = '<space>c',
    ---Block-comment keymap
    block = '<space>b',
  },

  extra = {
    ---Add comment on the line above
    above = '<space>cO',
    ---Add comment on the line below
    below = '<space>co',
    ---Add comment at the end of line
    eol = '<space>ca',
  },

  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
    extended = false,
  },

  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
