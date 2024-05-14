" General settings
filetype plugin on
syntax on
set breakindent smartindent
set completeopt=menu,menuone,noselect,preview
set cpoptions+=y
set cursorcolumn cursorline
set diffopt+=iwhite,iwhiteeol,vertical
set foldexpr=
set foldmethod=expr foldminlines=5 nofoldenable
set ignorecase smartcase
set inccommand=nosplit
set laststatus=3
set lazyredraw
set path+=**
set rnu nu
set scrolloff=10
set sessionoptions+=winpos,terminal
set shiftround
set signcolumn=yes
set spelllang=en spelloptions=camel
set splitbelow splitright
set suffixes+=*.class$
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set termguicolors
set title
set visualbell
set wildmenu
set wildmode=longest,full
set wildoptions=pum,tagfile
set wrap

" Automatically delete trailing white spaces on save
au BufWritePre * %s/\s\+$//e

" Custom file types
au BufRead,BufNewFile *.desktop,*.service set filetype=dosini
au BufRead,BufNewFile *.http,*.req set filetype=http
au BufRead,BufNewFile *.jq set filetype=jq
au BufRead,BufNewFile *.opml set filetype=html
au BufRead,BufNewFile *.templ set filetype=templ
au BufRead,BufNewFile fstab.* set filetype=fstab
au BufRead,BufNewFile sxhkdrc set filetype=sxhkdrc
au BufRead,BufNewFile *.uml set filetype=plantuml

" filetype-specific settings
au Filetype plaintex runtime settings/latex.vim
au Filetype markdown,plaintex set spell

" plugins
runtime settings/firenvim.vim
runtime settings/abbr.vim

set secure
