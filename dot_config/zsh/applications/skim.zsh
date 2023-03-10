#!/usr/bin/env zsh
#
# skim.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com
#
# Distributed under terms of the GPLv3 license.

if [ "$HOST" = "honshu" ] || [ "$HOST" = "hokkaido" ]; then
  source "/usr/share/skim/key-bindings.zsh"
  source "/usr/share/skim/completion.zsh"
elif [ "$HOST" = "K9J507N7L0" ]; then
  source "/opt/homebrew/Cellar/sk/0.10.4/share/zsh/site-functions/key-bindings.zsh"
  source "/opt/homebrew/Cellar/sk/0.10.4/share/zsh/site-functions/completion.zsh"
fi
