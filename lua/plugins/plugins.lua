local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--depth=1',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    -- '--branch=stable', -- issues/241
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require('lazy')

local is_linux = vim.loop.os_uname().sysname == 'Linux'
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, silent = true, desc = desc }) end

local function c(plugin)
  return function() require('plugins.' .. plugin) end
end

local plugins = {
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'arkav/lualine-lsp-progress' },
      { 'glepnir/lspsaga.nvim', event = 'LspAttach', dependencies = 'nvim-tree/nvim-web-devicons' },
    },
    config = c('lsp'),
  },

  -- Mason
  {
    'williamboman/mason.nvim',
    dependencies = {
      'jay-babu/mason-null-ls.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = c('mason'),
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'RRethy/nvim-treesitter-endwise' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/playground' },
    },
    config = c('ts'),
    build = ':TSUpdate',
  },

  -- formatting
  { 'nvimtools/none-ls.nvim', config = c('null-ls') },
  { 'echasnovski/mini.align', config = function() require('mini.align').setup() end },

  -- nvim config
  { 'folke/neodev.nvim', ft = 'lua', config = c('neodev') },
  { 'rafcamlet/nvim-luapad', ft = 'lua' },

  -- General UI
  { 'nvim-tree/nvim-web-devicons' },
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = c('lualine'),
  },
  { 'rcarriga/nvim-notify', config = c('notify') },
  { 'szw/vim-maximizer', config = c('maximizer') },

  -- Extending basic motions and editing
  -- Moving
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = c('harpoon'),
  },
  {
    'abecodes/tabout.nvim',
    dependencies = { 'nvim-treesitter' },
    config = c('tabout'),
  },
  { 'cbochs/portal.nvim', config = c('portal') },
  { 'ggandor/leap.nvim', config = c('leap') },
  { 'junegunn/vim-slash' },
  { 'unblevable/quick-scope' },
  -- Editing
  { 'ChocolateOverflow/toggle_words.vim', config = c('toggle_words') },
  { 'Wansmer/sibling-swap.nvim', config = c('sibling-swap') },
  { 'Wansmer/treesj', config = c('treesj') },
  { 'gbprod/substitute.nvim', config = c('substitute') },
  { 'sQVe/sort.nvim', config = c('sort') },
  { 'tpope/vim-repeat' },
  -- Text objects
  { 'andymass/vim-matchup', config = c('matchup') },
  { 'kiyoon/treesitter-indent-object.nvim', config = c('indent_object') },
  {
    'kylechui/nvim-surround',
    version = '*',
    config = c('surround'),
  },
  { 'wellle/targets.vim' },
  -- Misc
  { 'max397574/better-escape.nvim', config = c('better-escape') },
  { 'kevinhwang91/nvim-hlslens', config = c('hlslens') },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = c('telescope'),
  },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'jvgrootveld/telescope-zoxide' },

  -- goto-preview
  { 'rmagatti/goto-preview', config = c('preview') },

  -- commenting
  { 'numToStr/Comment.nvim', config = c('comment') },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },

  -- undo tree
  { 'mbbill/undotree', config = c('undotree') },

  -- refactoring
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = c('refactoring'),
  },

  -- diff
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- yank
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = { 'kkharji/sqlite.lua' },
    config = c('neoclip'),
  },
  { 'tversteeg/registers.nvim' },

  -- Debugging
  { 'mfussenegger/nvim-dap', config = c('dap') },
  { 'mfussenegger/nvim-dap-python' },
  { 'nvim-telescope/telescope-dap.nvim' },
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'folke/trouble.nvim', config = c('trouble') },

  -- Autocomplete & Snippets
  { 'ChocolateOverflow/vim-snippets' }, -- my snippets
  { 'danymat/neogen', config = c('neogen') }, -- generate doc comments for classes, functions, and types
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' }, -- nvim lua config
      { 'hrsh7th/cmp-path' },
      { 'onsails/lspkind.nvim' }, -- fancy completion menu
      { 'rasulomaroff/cmp-bufname' },
      { 'rcarriga/cmp-dap' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = c('cmp'),
  },
  { 'windwp/nvim-autopairs', config = c('autopair') },
  { 'windwp/nvim-ts-autotag', config = true },
  { 'L3MON4D3/luasnip', config = c('luasnip'), build = 'make install_jsregexp' }, -- snippets engine
  { 'Hoffs/omnisharp-extended-lsp.nvim' },

  -- git
  { 'lewis6991/gitsigns.nvim', config = c('gitsigns') },
  { 'tpope/vim-fugitive' },

  -- Building & running code
  { 'michaelb/sniprun', build = 'bash ./install.sh', enabled = is_linux, config = c('sniprun') },
  { 'CRAG666/code_runner.nvim', dependencies = 'nvim-lua/plenary.nvim', config = c('code_runner') },

  -- testing
  {
    'https://github.com/nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'thenbe/neotest-playwright',
    },
    config = c('neotest'),
  },
  { 'rest-nvim/rest.nvim', ft = 'http', config = c('rest') },

  -- Shell
  { 'itspriddle/vim-shellcheck', ft = 'sh' },

  -- Rust
  { 'rust-lang/rust.vim' },
  { 'simrat39/rust-tools.nvim' },

  -- Go
  { 'fatih/vim-go', ft = 'go', build = ':GoUpdateBinaries' },
  -- TODO: check out
  -- ('ray-x/go.nvim')
  -- ('olexsmir/gopher.nvim')

  -- SQL
  {
    'tpope/vim-dadbod',
    dependencies = {
      { 'kristijanhusak/vim-dadbod-ui' },
      { 'kristijanhusak/vim-dadbod-completion' },
    },
    ft = { 'sql', 'mysql', 'plsql' },
  },

  -- Markdown, LaTeX, and text
  { 'dkarter/bullets.vim', ft = { 'markdown', 'plaintex', 'text' }, config = c('bullets') },

  -- files browsing
  { 'is0n/fm-nvim', config = c('fm') },

  -- Browser
  { 'glacambre/firenvim', build = function() vim.fn['firenvim#install'](0) end },

  -- Project management
  { 'cljoly/telescope-repo.nvim' },
  { 'airblade/vim-rooter', config = c('rooter') },
  { 'tpope/vim-dotenv' },

  -- terminal integration
  { 'akinsho/toggleterm.nvim', version = '*', config = c('toggleterm') },

  -- Misc files
  { 'NoahTheDuke/vim-just' },

  -- Misc
  { 'axieax/urlview.nvim', config = c('urlview') },
  { 'ethanholz/nvim-lastplace', config = c('lastplace') },
}

local opts = {
  -- git = { url_format = 'git@github.com:%s' }, -- use SSH whenever possible
}

lazy.setup(plugins, opts)

nmap('<space>pp', lazy.home, '[P]lugins (lazy)')
nmap('<space>ph', lazy.health, '[P]lugins [H]ealth')
nmap('<space>ps', lazy.sync, '[P]lugins [S]ync')
nmap('<space>pu', lazy.update, '[P]lugins [U]pdate')
