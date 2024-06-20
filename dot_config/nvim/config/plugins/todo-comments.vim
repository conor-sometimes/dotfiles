" todo-comments.vim
"
" Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
"
" Distributed under terms of the GPLv3 license.
"
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
