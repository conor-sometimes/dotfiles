#!/usr/bin/env bash
#
# manage-drives.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o nounset
set -o errexit


# $1 = Label
unmount_drive() {
  if mountpoint --quiet /run/mount/"$1"; then
    echo "Closing $1"
    sudo umount /run/mount/"$1"
  fi

  if [ -b /dev/disk/by-label/"$1" ]; then
    echo "Locking $1"
    sudo cryptsetup luksClose /dev/mapper/"$1"
  fi
}


# $1 = Label
# $2 = UUID
# $3 = Password
mount_drive() {
  if [ ! -b /dev/disk/by-label/"$1" ]; then
    echo "Opening $1"
    echo -n "$3" | sudo cryptsetup luksOpen /dev/disk/by-uuid/"$2" "$1" --key-file -

    if [ ! -d /run/mount/"$1" ]; then
      sudo mkdir /run/mount/"$1"
    fi

    sudo mount /dev/disk/by-label/"$1" /run/mount/"$1"
    sudo chown "$USER" /run/mount/"$1"
  fi
}

# $1 = Action
# $2 = Label
# $3 = UUID
# $4 = Password
case "$1" in
  m)
    mount_drive "$2" "$3" "$4"
    ;;
  u)
    unmount_drive "$2"
    ;;
esac
