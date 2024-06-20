echom "Sourcing general configuration..."
source $HOME/.config/nvim/config/general-settings.vim
source $HOME/.config/nvim/config/functions.vim

" Plugins
echom "Sourcing plugin manager configuration..."
source $HOME/.config/nvim/config/plugins.vim

echom "Sourcing plugin configuration..."
let plugin_files = glob($HOME . "/.config/nvim/config/plugins/*.vim", 0, 1)
for f in plugin_files
	execute 'source ' . fnameescape(f)
endfor

" We source the keybinds configuration after the plugins to ensure that the
" keybinds are correctly set and not overwritten by the plugins.
echom "Sourcing keybinds configuration..."
source $HOME/.config/nvim/config/keybinds.vim

echom "Sourcing folding configuration..."
source $HOME/.config/nvim/config/folding.vim

echom "Sourcing status line configuration..."
source $HOME/.config/nvim/config/status-line.vim
