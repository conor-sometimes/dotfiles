" ale.vim
"
" Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
"
" Distributed under terms of the GPLv3 license.
"

let g:ale_enabled = 1
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1

let g:ale_linters = {
      \ 'rust': ['analyzer'],
      \ 'vim': ['vint'],
      \ 'sh': ['shellcheck', 'shfmt'],
      \ 'cpp': ['clang'],
      \ 'python': ['flake8'],
      \ 'tex': ['lacheck', 'proselint'],
      \ 'ps1': ['powershell'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'rust': ['rustfmt'],
      \ 'python': ['autopep8'],
      \ 'go': ['gofmt'],
      \ }

let g:ale_vim_vint_show_style_issues = 1
let g:ale_statusline_format = ['Error(s): %d', 'Warning(s): %d', '✓ ok']

nmap <silent> <C-j> <Plug>(ale_previous_wrap)

" linter options
let g:ale_sh_shellcheck_options = '-e SC1117 -P $HOME'

let g:cpp_clang_options = '-Iinclude -Weverything'

let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_all_targets = 1
" let g:ale_rust_analyzer_executable = system('which rust-analyzer')

" allows us to use clippy alongside rust-analyzer
let g:ale_rust_analyzer_config = { 'checkOnSave': { 'command': 'clippy', 'enable': v:true } }

let g:ale_powershell_powershell_executable = '/usr/local/bin/pwsh'

" Keybinds
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
