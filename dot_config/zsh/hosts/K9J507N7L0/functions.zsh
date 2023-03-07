#!/usr/bin/env zsh
#
# functions.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

# ta tech "delete browser history"
ta() {
  if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "ta work \"Do stuff\""
    return 1
  fi
  if [[ -v $3 ]]; then
    task add +$1 $2 depends:$3
  else
    task add +$1 $2
  fi
}
