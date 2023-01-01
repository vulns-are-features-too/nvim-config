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
    'json',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'php',
    'python',
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

  refactor = {
    highlight_current_scope = { enable = true },
    highlight_definitions = { enable = false },
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
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
      lookahead = true,
      swap_next = { ['<space><space>s'] = '@parameter.inner' },
      swap_previous = { ['<space><space>S'] = '@parameter.inner' },
    },
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  autopairs = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
})
