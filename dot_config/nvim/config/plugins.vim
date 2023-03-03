" plugins.vim
"
" Copyright (C) 2021 dindybutts
"
" Distributed under terms of the GPLv3 license.
"
filetype off
call plug#begin('~/.local/share/nvim/plugins')

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" lint
Plug 'dense-analysis/ale'

" colorscheme
Plug 'morhetz/gruvbox',
Plug 'nathanaelkane/vim-indent-guides'
Plug 'luochen1990/rainbow', { 'for': ['rust', 'cpp', 'c', 'sh', 'python', 'vim', 'tex'] }
Plug 'tpope/vim-commentary', { 'for': ['rust', 'cpp', 'vim', 'zsh', 'sh', 'c', 'asm', 'python', 'tex'] }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" misc
Plug 'ervandew/supertab'
Plug 'AndrewRadev/switch.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ap/vim-buftabline'
Plug 'phaazon/hop.nvim'
Plug 'aperezdc/vim-template'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/vim-cursorword'
Plug 'vimwiki/vimwiki'

Plug 'junegunn/vim-easy-align'

" LaTeX
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'

" markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'folke/todo-comments.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'mhinz/vim-startify'

Plug 'dhruvasagar/vim-table-mode'
Plug 'jamessan/vim-gnupg'

Plug 'chrisbra/csv.vim'
call plug#end()
filetype plugin indent on
