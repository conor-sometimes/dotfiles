#!/usr/bin/env zsh
#
# variables.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

export PROMPT_COLOR="yellow"

# $HOME/wiki/programs/gpg.wiki
export GPG_KEY="C59E2EA148098193BEEEE42087BFE2E84FE74F61"
export GPG_TTY="$(tty)"

# $HOME/wiki/programs/ssh.wiki
export SSH_KEY="$HOME/.ssh/macbook.pub"

export SSH_AUTH_SOCK=/Users/cmcshane/.yubiagent/sock
