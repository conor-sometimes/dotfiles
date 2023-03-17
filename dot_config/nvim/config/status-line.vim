" status-line.vim
"
" Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
"
" Distributed under terms of the GPLv3 license.

" Always display status
set laststatus=2

" Begin statusline
set statusline =

" Name of the current branch (needs fugitive.vim)
if has_key(plugs, 'vim-fugitive')
	set statusline +=%{fugitive#statusline()}
endif

" Ale specific
if has_key(plugs, 'ale')
	set statusline +=[W:%{ale#statusline#Count(bufnr('')).warning}]
	set statusline +=[E:%{ale#statusline#Count(bufnr('')).error}]
endif

" Add a gap
set statusline +=%=

" File description
set statusline +=%F

" Add a gap
set statusline +=%=

" Line, column, percentage and number of lines in the file
" set statusline +=[%l][%c][%L]
"
set statusline +=[%l][%L]

" Filetype
set statusline +=%y
