#!/usr/bin/env bash
#
# functions.sh
#
# Copyright (C) 2021 dindybutts
#
# Distributed under terms of the GPLv3 license.

# make this an array and iterate over all arguments
# this allows it to check multiple programs
check_dependency() {
  if [[ -x "$(command -v "$1")" ]]; then
    true
  else
    false
  fi
}

# this checks if the hostname is NOT what is being checked
# example:
# "check_hostname seele" = returns true if the hostname IS "seele"
check_hostname() {
  if [[ "$HOSTNAME" = "$1" ]]; then
    true
  else
    false
  fi
}

# check if dir exists, if it does, return true, otherwise return false
# example:
# "check_hostname /home/dind" = returns true if the directory exists
check_dir() {
  if [[ -d "$1" ]]; then
    true
  else
    false
  fi
}

# check if host is online, if it does, return true, otherwise return false
# example:
# "check_host $HOKKAIDO" = returns true if the directory exists
check_host() {
  if ping -q -W 0.1 -c 1 "$1" &>/dev/null; then
    true
  else
    false
  fi
}
