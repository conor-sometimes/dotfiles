#!/usr/bin/env bash
#
# sshfs.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

if [[ ! -d "$HOME/sshfs" ]]; then
  mkdir -p "$HOME/sshfs"
fi

sshfs -f -v dind@hokkaido:/ "$HOME/sshfs"

sleep 1

trap "rmdir $HOME/sshfs" exit
