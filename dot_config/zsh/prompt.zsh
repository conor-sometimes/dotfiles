#!/usr/bin/env zsh
#
# prompt.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "[%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del]"
  fi
}

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

PROMPT='[%F{yellow}%?%f] %n::%F{$PROMPT_COLOR}%M%{%f%}: %~ > '

RPROMPT='$(vcs_info_wrapper)'
if [[ $SHLVL > 1 ]]; then
  RPROMPT="$RPROMPT %F{red}SUBSHELL%f"
fi


# See also:
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
