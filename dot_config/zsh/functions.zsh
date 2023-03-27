#!/usr/bin/env zsh
#
# functions.zsh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

exterminate() {
  if [[ ! -z "$1" ]]; then
    pkill -f -9 "$1"
  fi
}

check_dir() {
  if [ ! -d "$1" ]; then
    echo "$1 doesn't exist"
  fi
}

push_all() {
  for REMOTE in $(git remote); do
    echo "$REMOTE"
    git push --all $REMOTE
  done
}

check_dupes() {
  grep -wo '[[:alnum:]]\+' "$1" | sort | uniq -dc
}

fpath() {
  echo $FPATH | awk -F: '{for (i=1;i<=NF;i++)print $i}'
}
