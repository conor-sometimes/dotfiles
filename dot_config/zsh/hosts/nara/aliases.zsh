#!/usr/bin/env zsh
#
# aliases.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

alias clean-orphans="comm -23 <(pacman -Qqt | sort) <(echo $ignorepkg | tr ' ' '\n' | cat <(pacman -Sqg $ignoregrp) - | sort -u)"
alias rm='trash-put'
