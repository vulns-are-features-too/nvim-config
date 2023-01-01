local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local is_bootstrapping = ensure_packer()

local is_linux = vim.loop.os_uname().sysname == 'Linux'

local function p(plugin)
  -- get string to require plugin config
  return 'require("plugins.' .. plugin .. '")'
end

local pkgs = function(use)
  -- PACKER
  use('wbthomason/packer.nvim')

  -- General UI
  use({ 'arkav/lualine-lsp-progress' })
  use({ 'kyazdani42/nvim-web-devicons' })
  use({ 'morhetz/gruvbox' })
  use({ 'nvim-lualine/lualine.nvim', config = p('lualine') })
  use({ 'rcarriga/nvim-notify', config = p('notify') })
  use({ 'szw/vim-maximizer', config = p('maximizer') })
  use({ 'jubnzv/virtual-types.nvim' })

  -- Extending basic motions and editing
  use({ 'ChocolateOverflow/toggle_words.vim', config = p('toggle_words') })
  use({ 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' }, config = p('harpoon') })
  use({ 'Wansmer/sibling-swap.nvim', config = p('sibling-swap') })
  use({ 'Wansmer/treesj', config = p('treesj') })
  use({ 'abecodes/tabout.nvim', wants = { 'nvim-treesitter' }, config = p('tabout') })
  use({ 'andymass/vim-matchup' })
  use({ 'cbochs/portal.nvim', requires = { 'ThePrimeagen/harpoon' }, config = p('portal') })
  use({ 'gbprod/substitute.nvim', config = p('substitute') })
  use({ 'ggandor/leap.nvim', config = p('leap') })
  use({ 'junegunn/vim-slash' })
  use({ 'kiyoon/treesitter-indent-object.nvim', config = p('indent_object') })
  use({ 'kylechui/nvim-surround', tag = '*', config = p('surround') })
  use({ 'max397574/better-escape.nvim', config = p('better-escape') })
  use({ 'sQVe/sort.nvim', config = p('sort') })
  use({ 'tpope/vim-abolish' })
  use({ 'tpope/vim-repeat' })
  use({ 'unblevable/quick-scope' })
  use({ 'wellle/targets.vim' })

  -- Tags
  use({ 'preservim/tagbar', config = p('tagbar') })

  -- LSP
  use({ 'dense-analysis/ale', config = p('ale') })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
  if is_linux then use({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = p('lsp_lines') }) end
  use({ 'neovim/nvim-lspconfig', config = p('lsp') })
  use({ 'ray-x/lsp_signature.nvim', config = p('lsp_signature') })

  -- tree-sitter
  use({ 'nvim-treesitter/nvim-treesitter', config = p('ts'), run = ':TSUpdate' })
  use({ 'nvim-treesitter/nvim-treesitter-context' })
  use({ 'nvim-treesitter/nvim-treesitter-refactor' })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
  use({ 'RRethy/nvim-treesitter-endwise' })

  -- telescope
  use({ 'nvim-telescope/telescope.nvim', config = p('telescope'), requires = { 'nvim-lua/plenary.nvim' } })
  use({ 'nvim-lua/popup.nvim' })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-file-browser.nvim' })
  use({ 'jvgrootveld/telescope-zoxide' })

  -- goto-preview
  use({ 'rmagatti/goto-preview', config = p('preview') })

  -- commenting
  use({ 'numToStr/Comment.nvim', config = p('comment') })
  use({ 'JoosepAlviste/nvim-ts-context-commentstring' })

  -- diff
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

  -- yank
  use({ 'AckslD/nvim-neoclip.lua', requires = { { 'kkharji/sqlite.lua', module = 'sqlite' } }, config = p('neoclip') })
  use({ 'tversteeg/registers.nvim' })

  -- Debugging
  use({ 'mfussenegger/nvim-dap', config = p('dap') })
  use({ 'mfussenegger/nvim-dap-python' })
  use({ 'nvim-telescope/telescope-dap.nvim' })
  use({ 'rcarriga/cmp-dap' })
  use({ 'rcarriga/nvim-dap-ui' })
  use({ 'theHamsta/nvim-dap-virtual-text' })
  use({ 'folke/trouble.nvim', config = p('trouble') })

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
  use({ 'hrsh7th/nvim-cmp', config = p('cmp') })
  use({ 'onsails/lspkind.nvim' }) -- fancy completion menu
  use({ 'saadparwaiz1/cmp_luasnip' })
  use({ 'windwp/nvim-autopairs', config = p('autopair') })
  use({ 'windwp/nvim-ts-autotag', config = 'require("nvim-ts-autotag").setup()' })
  use({ 'L3MON4D3/luasnip', config = p('luasnip'), rocks = { 'jsregexp' }, run = 'make install_jsregexp' }) -- snippets engine
  use({ 'tzachar/cmp-tabnine', run = './install.sh' }) -- AI trying to steal my job

  -- git
  use({ 'lewis6991/gitsigns.nvim', config = p('gitsigns') })
  use({ 'tpope/vim-fugitive' })

  -- Building & running code
  use({ 'michaelb/sniprun', run = 'bash ./install.sh', config = p('sniprun') })
  use({ 'CRAG666/code_runner.nvim', config = p('code_runner'), requires = 'nvim-lua/plenary.nvim' })

  -- testing
  use({ 'rest-nvim/rest.nvim', ft = 'http', config = p('rest') })

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

  -- files browsing
  use({ 'is0n/fm-nvim', config = p('fm') })

  -- Browser
  use({ 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end })

  -- Project management
  use({ 'cljoly/telescope-repo.nvim' })
  use({ 'airblade/vim-rooter', config = p('rooter') })

  -- Obsidian
  use({ 'epwalsh/obsidian.nvim', config = p('obsidian'), ft = { 'lua', 'markdown' } })

  -- tmux & terminal integration
  use({ 'christoomey/vim-tmux-navigator', config = p('tmux') })
  use({ 'akinsho/toggleterm.nvim', tag = '*', config = p('toggleterm') })

  -- Misc files
  use({ 'NoahTheDuke/vim-just', ft = 'just' })
  use({ 'bfrg/vim-jq', ft = 'jq' })

  -- Misc
  use({ 'axieax/urlview.nvim', config = p('urlview') })
  use({ 'ethanholz/nvim-lastplace', config = p('lastplace') })
  use({ 'lewis6991/impatient.nvim' })

  if is_bootstrapping then require('packer').sync() end
end

local config = {
  git = { default_url_format = 'git@github.com:%s' }, -- use SSH whenever possible
}

require('packer').startup({ pkgs, config })
require('impatient')

local v = vim.api
-- Reload & recompile plugins when this file is saved
v.nvim_create_augroup('PackerAug', { clear = true })
v.nvim_create_autocmd(
  'BufWritePost',
  { pattern = 'plugins.lua', group = 'PackerAug', command = 'source <afile> | PackerCompile' }
)
