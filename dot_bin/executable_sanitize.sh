#!/usr/bin/env bash
#
# sanitize.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset


echo "Anti-Fingerprinting"
declare -a FINGERPRINT=( "$HOME/.zhistory" "$HOME/.cache/rofi-3.runcache" )

for FINGERPRINT_FILE in "${FINGERPRINT[@]}"; do
  sed -E "/.*aunpack|unrar|unzip.*/d" -i "$FINGERPRINT_FILE"
  sed -E "/.*aria2c|magnet:?.*/d" -i "$FINGERPRINT_FILE"
  sed -E "/.*curl|wget|youtube-dl|yt-dlp.*/d" -i "$FINGERPRINT_FILE"
  sed -E "/.*.*API(|_)KEY.*|authtoken.*/d" -i "$FINGERPRINT_FILE"
  sed -E "/.*bashtag|link_handle.*/d" -i "$FINGERPRINT_FILE"
  sed -E "/.*zathura|task\ add.*/d" -i "$FINGERPRINT_FILE"

  # remove empty line
  sed -i "/^$/d" "$FINGERPRINT_FILE"
done

# echo "Removing mpv watch later files"
# rm -f "$HOME"/.local/share/mpv/watch_later/*

# echo "Ranger history"
# rm -f "$HOME/.local/share/ranger/history"

# echo "Zathura history"
# rm -f "$HOME/.local/share/zathura/history"
