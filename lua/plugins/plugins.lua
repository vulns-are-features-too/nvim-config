local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--depth=1',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require('lazy')

local is_linux = vim.loop.os_uname().sysname == 'Linux'
local function nmap(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

local function c(plugin)
  return function() require('plugins.' .. plugin) end
end

local plugins = {
  -- Core Plugins
  { 'neovim/nvim-lspconfig', config = c('lsp') },
  { 'jose-elias-alvarez/null-ls.nvim', config = c('null-ls') },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    config = c('mason'),
  },

  -- General UI
  { 'arkav/lualine-lsp-progress' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'morhetz/gruvbox', lazy = false, priority = 1000 },
  { 'nvim-lualine/lualine.nvim', config = c('lualine') },
  { 'rcarriga/nvim-notify', config = c('notify') },
  { 'szw/vim-maximizer', config = c('maximizer') },
  { 'jubnzv/virtual-types.nvim' },
  { 'folke/lsp-colors.nvim' },

  -- Extending basic motions and editing
  { 'ChocolateOverflow/toggle_words.vim', config = c('toggle_words') },
  { 'ThePrimeagen/harpoon', dependencies = { 'nvim-lua/plenary.nvim' }, config = c('harpoon') },
  { 'Wansmer/sibling-swap.nvim', config = c('sibling-swap') },
  { 'Wansmer/treesj', config = c('treesj') },
  { 'abecodes/tabout.nvim', dependencies = { 'nvim-treesitter' }, config = c('tabout') },
  { 'andymass/vim-matchup' },
  { 'cbochs/portal.nvim', dependencies = { 'ThePrimeagen/harpoon' }, config = c('portal') },
  { 'gbprod/substitute.nvim', config = c('substitute') },
  { 'ggandor/leap.nvim', config = c('leap') },
  { 'junegunn/vim-slash' },
  { 'kiyoon/treesitter-indent-object.nvim', config = c('indent_object') },
  { 'kylechui/nvim-surround', version = '*', config = c('surround') },
  { 'max397574/better-escape.nvim', config = c('better-escape') },
  { 'sQVe/sort.nvim', config = c('sort') },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-repeat' },
  { 'unblevable/quick-scope' },
  { 'wellle/targets.vim' },

  -- Tags
  { 'preservim/tagbar', config = c('tagbar') },

  -- LSP
  { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', enabled = is_linux, config = c('lsp_lines') },
  { 'ray-x/lsp_signature.nvim', config = c('lsp_signature') },

  -- tree-sitter
  { 'nvim-treesitter/nvim-treesitter', config = c('ts'), build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-endwise' },
  { 'nvim-treesitter/playground' },

  -- telescope
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = c('telescope') },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'jvgrootveld/telescope-zoxide' },

  -- goto-preview
  { 'rmagatti/goto-preview', config = c('preview') },

  -- commenting
  { 'numToStr/Comment.nvim', config = c('comment') },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },

  -- refactoring
  { 'ThePrimeagen/refactoring.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' }, config = c('refactoring') },

  -- diff
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- yank
  { 'AckslD/nvim-neoclip.lua', dependencies = { 'kkharji/sqlite.lua' }, config = c('neoclip') },
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
      { 'rcarriga/cmp-dap' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'tzachar/cmp-tabnine', build = './install.sh' }, -- AI trying to steal my job
    },
    config = c('cmp'),
  },
  { 'onsails/lspkind.nvim' }, -- fancy completion menu
  { 'windwp/nvim-autopairs', config = c('autopair') },
  { 'windwp/nvim-ts-autotag', config = true },
  { 'L3MON4D3/luasnip', config = c('luasnip'), rocks = { 'jsregexp' }, build = 'make install_jsregexp' }, -- snippets engine

  -- git
  { 'lewis6991/gitsigns.nvim', config = c('gitsigns') },
  { 'tpope/vim-fugitive' },

  -- Building & running code
  { 'michaelb/sniprun', build = 'bash ./install.sh', config = c('sniprun') },
  { 'CRAG666/code_runner.nvim', dependencies = 'nvim-lua/plenary.nvim', config = c('code_runner') },

  -- testing
  { 'rest-nvim/rest.nvim', ft = 'http', config = c('rest') },

  -- Shell
  { 'itspriddle/vim-shellcheck', ft = 'sh' },

  -- Rust
  { 'rust-lang/rust.vim', ft = 'rust' },
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
  { 'dkarter/bullets.vim', ft = { 'markdown', 'plaintex', 'text' } },

  -- files browsing
  { 'is0n/fm-nvim', config = c('fm') },

  -- Browser
  { 'glacambre/firenvim', build = function() vim.fn['firenvim#install'](0) end },

  -- Project management
  { 'cljoly/telescope-repo.nvim' },
  { 'airblade/vim-rooter', config = c('rooter') },

  -- Obsidian
  { 'epwalsh/obsidian.nvim', config = c('obsidian'), ft = { 'lua', 'markdown' } },

  -- tmux & terminal integration
  { 'christoomey/vim-tmux-navigator', config = c('tmux') },
  { 'akinsho/toggleterm.nvim', version = '*', config = c('toggleterm') },

  -- Misc files
  { 'NoahTheDuke/vim-just', ft = 'just' },

  -- Misc
  { 'axieax/urlview.nvim', config = c('urlview') },
  { 'ethanholz/nvim-lastplace', config = c('lastplace') },
}

local opts = {
  -- git = { url_format = 'git@github.com:%s' }, -- use SSH whenever possible
}

lazy.setup(plugins, opts)

nmap('<space>pp', lazy.home)
nmap('<space>pd', lazy.debug)
nmap('<space>ph', lazy.health)
nmap('<space>pl', lazy.log)
nmap('<space>ps', lazy.sync)
nmap('<space>pu', lazy.update)
