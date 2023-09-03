#!/usr/bin/env zsh
#
# path.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

export PATH="$HOME/.bin"             # dotfile scripts
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export PATH="$PATH:$HOME/go/bin"     # go
export PATH="$PATH:$HOME/.local/bin" # pip
export PATH="$PATH:/bin"             # root bin
export PATH="$PATH:/usr/bin"         # usr bin
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/run/wrappers/bin"
export PATH="$PATH:/home/conor/.nix-profile/bin"
export PATH="$PATH:/etc/profiles/per-user/conor/bin"
export PATH="$PATH:/nix/var/nix/profiles/default/bin"
export PATH="$PATH:/run/current-system/sw/bin"
