" plugin-configs.vim
"
" Copyright (C) 2021 dindybutts
"
" Distributed under terms of the GPLv3 license.
"
" ale {{{
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
let g:ale_rust_analyzer_executable = trim(system('rustup which --toolchain stable rust-analyzer'))

" allows us to use clippy alongside rust-analyzer
let g:ale_rust_analyzer_config = { 'checkOnSave': { 'command': 'clippy', 'enable': v:true } }

" Keybinds
nnoremap <silent> <F3> :call ToggleLocationList()<cr>
nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
" }}}

" commentary {{{
map <Leader>c :Commentary<CR>
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" hop.nvim {{{
nmap <leader>o :HopWord<CR>
nmap <leader>s :HopLine<CR>
" }}}

" gruvbox {{{
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'
set background=dark
" }}}

" rainbow {{{
let g:rainbow_active = 1
" }}}

" supertab {{{
let g:SuperTabDefaultCompletionType = '<c-n>'
" }}}

" switch {{{
let g:switch_mapping = '-'
let g:switch_custom_definitions =
      \ [
      \   ['"1"', '"0"',],
      \   ['1', '0',],
      \   ['yes', 'no'],
      \   ['on', 'off'],
      \   ['fg', 'bg'],
      \   ['-', '+'],
      \   ['allow', 'deny'],
      \   ['foreground', 'background'],
      \   ['overline', 'underline']
      \ ]
" }}}

" ultisnips {{{
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'custom-snippets']

let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-Right>' " TODO: make me more ergonomic, Update vim.md when you change this
let g:UltiSnipsJumpBackwardTrigger='<c-Left>'

let g:snips_author = 'dind#7958'
" }}}

" gitgutter {{{
set signcolumn=yes
let g:gitgutter_map_keys = 0
" }}}

" indent guides {{{
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1
let g:indent_guides_auto_colors = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" }}}

" templates {{{
let g:templates_directory = '$HOME/.config/nvim/templates'
let g:license = 'GPLv3'
let g:email = 'conor-sometimes <conor dot d dot mcshane at gmail dot com>'
let g:user = 'Conor McShane'
" }}}

" vimwiki {{{
let g:vimwiki_list = [{'path': '~/wiki/'}]


" allows me to use the marker foldmethod
" let g:vimwiki_folding = 'expr'

" allows me to use supertab
let g:vimwiki_table_mappings=0
let g:vimwiki_table_auto_fmt=0
"}}}

" latex live preview {{{
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'xelatex'
" }}}

" nvim-treesitter {{{
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
" }}}

" todo-comments {{{
lua << EOF
require("todo-comments").setup {
	keywords = {
		FIX = {
			icon = "> ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
			},
		TODO = { icon = "T ", color = "info" },
		HACK = { icon = "H ", color = "warning" },
		WARN = { icon = "W ", color = "warning", alt = { "WARNING", "XXX" } },
		NOTE = { icon = "N ", color = "hint", alt = { "INFO" } },
		},

	highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		},
	colors = {
		info = { "LspDiagnosticsDefaultInformation", "#D3869B" },
		},
	}
EOF

function! ToggleQuickFix()
	if empty(filter(getwininfo(), 'v:val.quickfix'))
		TodoQuickFix
	else
		cclose
	endif
endfunction

nnoremap <silent> <F2> :call ToggleQuickFix()<cr>
" }}}

" fugitive {{{
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gs :Git<CR>
nnoremap <space>gc :Git commit<CR><CR>
nnoremap <space>gp :Git push<CR><CR>
nnoremap <space>gd :Git diff<CR><CR>
" }}}

" hop {{{
lua << EOF
require("hop").setup()
EOF
" }}}

" vimtex {{{
let maplocalleader = ','
" }}}
