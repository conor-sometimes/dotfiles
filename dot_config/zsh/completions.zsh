#!/usr/bin/env zsh
#
# completions.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.
autoload -Uz compinit vcs_info

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.cache/zcompdump
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*:task:*' group-name ''

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':vcs_info:git:*' formats '%b'
