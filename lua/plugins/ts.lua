local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

local function nmap(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'diff',
    'dockerfile',
    'go',
    'haskell',
    'html',
    'http',
    'java',
    'javascript',
    'jq',
    'json',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'php',
    'python',
    'query',
    'rasi',
    'regex',
    'rust',
    'sql',
    'sxhkdrc',
    'toml',
    'typescript',
    'vim',
    'yaml',
  },
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<space>v',
      node_incremental = 'sn',
      scope_incremental = 'sN',
      node_decremental = 'sm',
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aB'] = '@block.outer',
        ['iB'] = '@block.inner',
        ['af'] = '@call.outer',
        ['if'] = '@call.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['aF'] = '@function.outer',
        ['iF'] = '@function.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = { ['<space><space>l'] = '@parameter.inner' },
      swap_previous = { ['<space><space>h'] = '@parameter.inner' },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']C'] = '@class.outer',
        [']F'] = '@function.outer',
        [']a'] = '@parameter.outer',
        [']c'] = '@conditional.outer',
        [']f'] = '@call.outer',
        [']l'] = '@loop.outer',
      },
      goto_previous_start = {
        ['[C'] = '@class.outer',
        ['[F'] = '@function.outer',
        ['[a'] = '@parameter.outer',
        ['[c'] = '@conditional.outer',
        ['[f'] = '@call.outer',
        ['[l'] = '@loop.outer',
      },
    },
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
  },

  autopairs = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
  matchup = { enable = true },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Repeat movement with ; and ,
nmap(';', ts_repeat_move.repeat_last_move_next)
nmap(',', ts_repeat_move.repeat_last_move_previous)
nmap('f', ts_repeat_move.builtin_f)
nmap('F', ts_repeat_move.builtin_F)
nmap('t', ts_repeat_move.builtin_t)
nmap('T', ts_repeat_move.builtin_T)
nmap('<leader>ts', '<Cmd>TSPlaygroundToggle<CR>')
