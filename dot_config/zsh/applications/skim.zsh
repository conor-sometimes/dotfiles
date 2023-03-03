#!/usr/bin/env zsh
#
# skim.zsh
#
# Copyright (C) 2021 dindybutts <lewdavatar at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

if [ "$HOST" = "honshu" ] || [ "$HOST" = "hokkaido" ]; then
  source "/usr/share/skim/key-bindings.zsh"
  source "/usr/share/skim/completion.zsh"
fi
