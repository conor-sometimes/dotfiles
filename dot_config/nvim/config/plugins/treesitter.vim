" treesitter.vim
"
" Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
"
" Distributed under terms of the GPLv3 license.
"

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c', 'cpp', 'rust', 'bash', 'comment', 'latex'
  },
  indent = {
    enable = false
  },
  highlight = {
    enable = true,
  }
}
EOF
