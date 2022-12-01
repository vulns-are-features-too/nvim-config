local function p(plugin)
  -- get string to require plugin config
  return 'require("plugins.' .. plugin .. '")'
end

local pkgs = function(use)
  -- PACKER
  use('wbthomason/packer.nvim')

  -- General UI
  use({ 'arkav/lualine-lsp-progress' })
  use({ 'chrisbra/colorizer' })
  use({ 'kyazdani42/nvim-web-devicons', opt = true })
  use({ 'morhetz/gruvbox' })
  use({ 'nvim-lualine/lualine.nvim', config = p('lualine') })
  use({ 'rcarriga/nvim-notify' })
  use({ 'szw/vim-maximizer', config = p('maximizer') })
  use({ 'jubnzv/virtual-types.nvim' })

  -- Extending basic motions and editing
  use({ 'AndrewRadev/splitjoin.vim' })
  use({ 'ChocolateOverflow/toggle_words.vim', config = p('toggle_words') })
  use({ 'andymass/vim-matchup' })
  use({ 'ggandor/leap.nvim', config = [[require('leap').add_default_mappings()]] })
  use({ 'junegunn/vim-slash' })
  use({ 'tpope/vim-repeat' })
  use({ 'kylechui/nvim-surround', tag = '*', config = function() require('nvim-surround').setup({}) end })
  use({ 'unblevable/quick-scope' })
  use({
    'gbprod/substitute.nvim',
    config = [[require('substitute').setup({})]],
  })
  use({
    'sQVe/sort.nvim',
    config = [[require('sort').setup()]],
  })

  -- Tags
  use({ 'preservim/tagbar' })

  -- LSP
  use({ 'dense-analysis/ale', config = p('ale') })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
  use({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = p('lsp_lines') })
  use({ 'neovim/nvim-lspconfig', config = p('lsp') })
  use({ 'ray-x/lsp_signature.nvim', config = p('lsp_signature') })

  -- tree-sitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = p('tree-sitter'),
    run = ':TSUpdate',
  })
  use({ 'nvim-treesitter/nvim-treesitter-context' })
  use({ 'nvim-treesitter/nvim-treesitter-refactor' })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
  use({ 'RRethy/nvim-treesitter-endwise' })

  -- telescope
  use({
    'nvim-telescope/telescope.nvim',
    config = p('telescope'),
    requires = { 'nvim-lua/plenary.nvim' },
  })
  use({ 'nvim-lua/popup.nvim' })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-file-browser.nvim' })

  -- goto-preview
  use({
    'rmagatti/goto-preview',
    config = [[require('goto-preview').setup()]],
  })

  -- commenting
  use({ 'numToStr/Comment.nvim', config = p('comment') })
  use({ 'JoosepAlviste/nvim-ts-context-commentstring' })

  -- diff
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

  -- yank
  use({
    'AckslD/nvim-neoclip.lua',
    requires = {
      { 'kkharji/sqlite.lua', module = 'sqlite' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = p('neoclip'),
  })
  use({ 'tversteeg/registers.nvim' })

  -- Debugging
  use({ 'mfussenegger/nvim-dap', config = p('dap') })
  use({ 'mfussenegger/nvim-dap-python' })
  use({ 'nvim-telescope/telescope-dap.nvim' })
  use({ 'rcarriga/cmp-dap' })
  use({ 'rcarriga/nvim-dap-ui' })
  use({ 'theHamsta/nvim-dap-virtual-text' })
  use({
    'folke/trouble.nvim',
    config = [[require('trouble').setup()]],
  })

  -- Formatting
  use({ 'jose-elias-alvarez/null-ls.nvim', config = p('null-ls') })

  -- Autocomplete & Snippets
  use({ 'ChocolateOverflow/vim-snippets' }) -- my snippets
  use({ 'danymat/neogen', config = p('neogen') }) -- generate doc comments for classes, functions, and types
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-cmdline' })
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-nvim-lua' }) -- nvim lua config
  use({ 'hrsh7th/cmp-path' })
  use({ 'hrsh7th/nvim-cmp', config = p('completion') })
  use({ 'onsails/lspkind.nvim' }) -- fancy completion menu
  use({ 'saadparwaiz1/cmp_luasnip' })
  use({ 'windwp/nvim-autopairs', config = p('autopair') })
  use({ 'windwp/nvim-ts-autotag', config = [[require('nvim-ts-autotag').setup()]] })
  use({
    'L3MON4D3/luasnip',
    config = p('luasnip'),
    rocks = { 'jsregexp' },
    run = 'make install_jsregexp',
  }) -- snippets engine
  use({ 'tzachar/cmp-tabnine', run = './install.sh' }) -- AI trying to steal my job

  -- git
  use({ 'kdheepak/lazygit.nvim', cmd = 'LazyGit' })
  use({ 'lewis6991/gitsigns.nvim', config = p('gitsigns') })
  use({ 'tpope/vim-fugitive' })

  -- Building & running code
  use({ 'tpope/vim-dispatch' })
  use({ 'michaelb/sniprun', run = 'bash ./install.sh' })
  use({
    'CRAG666/code_runner.nvim',
    config = p('code_runner'),
    requires = 'nvim-lua/plenary.nvim',
  })

  -- Shell
  use({ 'itspriddle/vim-shellcheck', ft = 'sh' })

  -- Rust
  use({ 'rust-lang/rust.vim', ft = 'rust' })
  use({ 'simrat39/rust-tools.nvim' })

  -- Go
  use({ 'fatih/vim-go', ft = 'go', run = ':GoUpdateBinaries' })
  -- TODO: check out
  -- use('ray-x/go.nvim')
  -- use('olexsmir/gopher.nvim')

  -- Markdown, LaTeX, and text
  use({ 'dkarter/bullets.vim', ft = { 'markdown', 'plaintex', 'text' } })

  -- UML
  use({ 'aklt/plantuml-syntax', ft = 'plantuml' })

  -- Utilities
  use({ 'wellle/targets.vim' })
  use({
    'pechorin/any-jump.vim',
    cmd = { 'AnyJump', 'AnyJumpLastResults' },
    config = p('any-jump'),
  })

  -- Browser
  use({
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
  })

  -- Project management
  use({ 'ahmedkhalf/project.nvim', config = p('project') })

  -- Obsidian
  use({
    'epwalsh/obsidian.nvim',
    config = p('obsidian'),
    ft = { 'lua', 'markdown' },
  })

  -- Misc files
  use({ 'NoahTheDuke/vim-just', ft = 'just' })
  use({ 'bfrg/vim-jq', ft = 'jq' })

  -- Misc
  use({ 'axieax/urlview.nvim', config = p('urlview') })
  use({ 'ethanholz/nvim-lastplace', config = p('lastplace') })
  use({ 'lewis6991/impatient.nvim' })
end

local config = {
  git = {
    -- use SSH whenever possible
    default_url_format = 'git@github.com:%s',
  },
}

require('packer').startup({ pkgs, config })
require('impatient')
