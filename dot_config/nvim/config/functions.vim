" functions.vim
"
" Copyright (C) 2021 dindybutts
"
" Distributed under terms of the GPLv3 license.
"
" auto reload certain files when changed
augroup reload_files
  autocmd!
  autocmd BufWritePost *.vim source $MYVIMRC
augroup END
