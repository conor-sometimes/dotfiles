" general-settings.vim
"
" Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
"
" Distributed under terms of the GPLv3 license.
"
" yes
set encoding=utf-8

" syntax highlighting
syntax enable

" Required for operations modifying multiple buffers like rename.
set hidden

" gotta improve my subtraction skills using 'd'
set relativenumber
set number

set scrolloff=10

" columns and wrapping
set colorcolumn=80
set nowrap

set autowrite

" UgandaBeGone!
set shortmess=atOI

" spelling
set spell spelllang=en_us

" Highlights current line
set cursorline
set cursorcolumn
set showcmd
set hlsearch

" case search
set ignorecase
set smartcase

" indent stuff
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set formatoptions+=j

" no annoying scratch window
" set completeopt-=preview

set undodir=~/.local/share/nvim/undodir/
set undofile

" Persistant undo
let g:vimDir = '$HOME/.config/nvim'
let &runtimepath.=','.g:vimDir

" splits
set splitbelow
set splitright

" words with dashes are now seen as one whole word
" instead of words separated by dashes
set iskeyword+=-

" sudo pacman -S words
set dictionary+=/usr/share/dict/words
set complete+=k
set infercase
