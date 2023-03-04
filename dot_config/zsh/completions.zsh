#!/usr/bin/env zsh
#
# completions.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

autoload -Uz compinit vcs_info

fpath=(
  "/usr/share/zsh/site-functions"
  "/usr/share/zsh/functions"
  "/usr/share/zsh/functions/Calendar"
  "/usr/share/zsh/functions/Chpwd"
  "/usr/share/zsh/functions/Completion"
  "/usr/share/zsh/functions/Completion/Base"
  "/usr/share/zsh/functions/Completion/Linux"
  "/usr/share/zsh/functions/Completion/Unix"
  "/usr/share/zsh/functions/Completion/X"
  "/usr/share/zsh/functions/Completion/Zsh"
  "/usr/share/zsh/functions/Exceptions"
  "/usr/share/zsh/functions/Math"
  "/usr/share/zsh/functions/MIME"
  "/usr/share/zsh/functions/Misc"
  "/usr/share/zsh/functions/Newuser"
  "/usr/share/zsh/functions/Prompts"
  "/usr/share/zsh/functions/TCP"
  "/usr/share/zsh/functions/VCS_Info"
  "/usr/share/zsh/functions/VCS_Info/Backends"
  "/usr/share/zsh/functions/Zftp"
  "/usr/share/zsh/functions/Zle"

  "$HOME/repos/zsh-completions"
)

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
