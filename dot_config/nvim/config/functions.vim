" functions.vim
"
" Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
"
" Distributed under terms of the GPLv3 license.
"
" auto reload certain files when changed
augroup reload_files
  autocmd!
  autocmd BufWritePost *.vim source $MYVIMRC
augroup END
