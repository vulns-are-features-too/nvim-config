local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

vim.g.toggle_words_dict = {
  all = {
    { 'true', 'false' },
    { 'if', 'else' },
    { 'allow', 'deny' },
    { 'before', 'after' },
    { 'good', 'bad' },
    { 'in', 'out' },
    {
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'october',
      'november',
      'december',
    },
    { 'left', 'right' },
    { 'min', 'max' },
    { 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday' },
    { 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' },
    { 'on', 'off' },
    { 'enable', 'disable' },
    { 'start', 'stop' },
    { 'success', 'failure' },
    { 'up', 'down' },
    { 'yes', 'no' },
    { 'and', 'or' },
  },
  sh = {
    { 'if', 'elif', 'else', 'fi' },
  },
  python = {
    { 'if', 'elif', 'else' },
  },
  java = {},
  rust = {
    { 'Ok', 'Err' },
  },
  go = {},
  c = {
    { 'define', 'undef' },
    { 'if', 'elif', 'else', 'endif' },
  },
  cpp = {
    { 'define', 'undef' },
  },
  vim = {
    { 'if', 'else', 'endif' },
  },
}

nmap('<space>t', '<Cmd>ToggleWord<CR>')
nmap('<C-T>', '<Cmd>ToggleWord<CR>')
nmap('<C-S-T>', '<Cmd>ToggleWordRev<CR>')
