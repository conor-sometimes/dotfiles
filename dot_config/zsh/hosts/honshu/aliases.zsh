#!/usr/bin/env zsh
#
# aliases.zsh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

alias clean-orphans="comm -23 <(pacman -Qqt | sort) <(echo $ignorepkg | tr ' ' '\n' | cat <(pacman -Sqg $ignoregrp) - | sort -u)"
alias rm='trash-put'
