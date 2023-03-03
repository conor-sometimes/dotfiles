#!/usr/bin/env bash
#
# sshfs.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

if [[ ! -d "$HOME/sshfs" ]]; then
  mkdir -p "$HOME/sshfs"
fi

sshfs -f -v dind@hokkaido:/ "$HOME/sshfs"

sleep 1

trap "rmdir $HOME/sshfs" exit
