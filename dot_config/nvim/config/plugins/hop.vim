" hop.vim
"
" Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
"
" Distributed under terms of the GPLv3 license.
"

nmap <leader>o :HopWord<CR>
nmap <leader>s :HopLine<CR>

lua << EOF
require("hop").setup()
EOF
