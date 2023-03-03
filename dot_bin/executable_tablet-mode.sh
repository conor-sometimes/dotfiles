#!/usr/bin/env bash
#
# tablet-mode.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

case "$1" in
  "on")
    xrandr \
      --output DP-4 --primary --mode 1920x1080 --rate 239.76 \
      --output DP-0 --mode 1920x1080 --rate 144 --right-of DP-4 \
      --output HDMI-0 --below DP-4 --mode 1920x1080 --rate 60.00

    otd & disown
    exit 1
    ;;
  "off")
    xrandr \
      --output DP-4 --primary --mode 1920x1080 --rate 239.76 \
      --output DP-0 --mode 1920x1080 --rate 144 --right-of DP-4 \
      --output HDMI-0 --off

    pkill dotnet
    exit 1
    ;;
  *)
    echo "Invalid option $REPLY"
    exit 1
    ;;
esac
