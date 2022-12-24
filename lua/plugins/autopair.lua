local npairs = require('nvim-autopairs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

npairs.setup({
  check_ts = true,
  enable_afterquote = false,
  enable_check_bracket_line = false, -- don't close if the next bracket doesn't have an opening bracket
  ignored_next_char = '[%w%.]', -- ignore alphanumeric and `.` symbol
  fast_wrap = {
    map = '<C-f>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
})

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
