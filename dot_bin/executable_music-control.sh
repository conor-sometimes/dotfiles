#!/usr/bin/env bash
#
# music-control.sh
#
# Copyright (C) 2021 dindybutts
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

# mpd takes priority over mpd
if [[ $(pgrep mpd) ]]; then
  case "$1" in
    next)
      mpc next
      ;;
    prev)
      mpc prev
      ;;
    stop)
      mpc stop
      ;;
    seekForward)
      mpc seek +5
      ;;
    seekBackward)
      mpc seek -5
      ;;
    toggle)
      mpc toggle
      ;;
  esac
else
  case "$1" in
    next)
      echo '{ "command": ["playlist_next"] }' | socat - /tmp/mpvsocket
      notify-desktop "$(echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | jq '.data')"
      ;;
    prev)
      echo '{ "command": ["playlist_prev"] }' | socat - /tmp/mpvsocket
      notify-desktop "$(echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | jq '.data')"
      ;;
    stop)
      echo '{ "command": ["set_property", "pause", true] }' | socat - /tmp/mpvsocket
      ;;
    seekForward)
      echo '{ "command": ["seek", "10"] }' | socat - /tmp/mpvsocket
      ;;
    seekBackward)
      echo '{ "command": ["seek", "-10"] }' | socat - /tmp/mpvsocket
      ;;
    toggle)
      echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket
      ;;
  esac
fi
