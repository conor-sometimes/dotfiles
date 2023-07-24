#!/usr/bin/env zsh
#
# path.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

export PATH="/opt/homebrew/bin"
export PATH="$PATH:$HOME/.bin"             # dotfile scripts
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export PATH="$PATH:$HOME/go/bin"     # go
export PATH="$PATH:$HOME/.local/bin" # pip
export PATH="$PATH:/bin"             # root bin
export PATH="$PATH:/usr/bin"         # usr bin
export PATH="$PATH:/sbin"            # mac bin
export PATH="$PATH:/usr/local/bin"
