#!/usr/bin/env zsh
#
# variables.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

export PROMPT_COLOR="red"

# this stops gpg from yelling at me while in ssh
export GPG_KEY="7032F7F9BC73C52B99956EB1F79E4AE90F072A31"
export GPG_TTY="$(tty)"

# this also stops tmux from yelling at me when in ssh
export TERM="screen-256color"
