" keybinds.vim
"
" Copyright (C) 2021 dindybutts
"
" Distributed under terms of the GPLv3 license.
"
" unbind certain keys
for g:prefix in ['i', 'n', 'v']
  for g:key in ['<Up>', '<Down>', '<Left>', '<Right>', '<Home>', '<End>', '<Del>', '<PAGEUP>', '<PAGEDOWN>', '<ScrollWheelUp>', '<ScrollWheelDown>', '<S-ScrollWheelUp>', '<S-ScrollWheelDown>']
    exe g:prefix . 'noremap ' . g:key . ' <Nop>'
  endfor
endfor

for g:prefix in ['n']
  for g:key in ['<CR>', '<BS>', '<Space>']
    exe g:prefix . 'noremap ' . g:key . ' <Nop>'
  endfor
endfor

" Map space to leader
map <space> <leader>

" Clears previous search highlighting
nnoremap <CR> :noh<CR><CR>

" buffer movement
nnoremap <leader>h :bprev<CR>
nnoremap <leader>l :bnext<CR>

" handy key to escape without reaching to the top left
inoremap jj <ESC>

" Opens documentation of word below cursor
nnoremap <F1> :help <C-r><C-w><CR>

" open file under cursor with feh
nnoremap gO :silent !feh <cfile> &<CR>

nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
