#!/usr/bin/env zsh
#
# aliases.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

# Host agnostic aliases
alias reload='RELOAD=1 source $HOME/.zshrc'
alias attach='tmux attach'
alias burndown='task burndown.daily'
alias ccd='chezmoi cd'
# Doesn't work on macos
# ls: invalid option -- X
# alias ls='ls -lAGh1vX --group-directories-first --color'
