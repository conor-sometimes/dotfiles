#!/usr/bin/env zsh
#
# variables.zsh
#
# Copyright (C) 2021 dindybutts <lewdavatar at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

export PROMPT_COLOR="red"

# this stops gpg from yelling at me while in ssh
export GPG_TTY="$(tty)"

# this also stops tmux from yelling at me when in ssh
export TERM="screen-256color"
