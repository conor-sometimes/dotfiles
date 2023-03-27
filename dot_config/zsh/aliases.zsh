#!/usr/bin/env zsh
#
# aliases.zsh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

# Host agnostic aliases
alias reload='RELOAD=1 source $HOME/.zshrc'
alias attach='tmux attach'
alias burndown='task burndown.daily'
# Doesn't work on macos because macos is weird
# ls: invalid option -- X
# alias ls='ls -lAGh1vX --group-directories-first --color'

# chezmoi
alias czd='chezmoi cd'
alias cza='chezmoi -v apply'
alias czu='chezmoi -v update'

# git
alias ga='git add -A'
alias gc='git commit -s -v'
alias gp='git push -u origin main'
alias gs='git status'
