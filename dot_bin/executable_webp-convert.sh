#!/usr/bin/env bash
#
# webp-convert.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

for WEBP in "$1"/*.webp; do
  if [ -f "$WEBP" ]; then
    dwebp "$WEBP" -o "${WEBP%.*}.png"
    if [ -f "${WEBP%.*}.png" ]; then
      rm "$WEBP"
    fi
  fi
done
