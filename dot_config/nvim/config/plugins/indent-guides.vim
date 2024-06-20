" indent-guides.vim
"
" Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
"
" Distributed under terms of the GPLv3 license.
"

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1
let g:indent_guides_auto_colors = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
