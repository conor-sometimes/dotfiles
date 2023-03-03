#!/usr/bin/env bash
#
# clean-android.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o nounset
shopt -s extglob

MOUNT_DIR="$HOME/mount"

# Doujin pages
# matches:
# 4.jpg
# 5(2).jpg

# for FILE in "$HOME/mount/Internal storage/Download"/{[0-9],[0-9]\([0-9]\)}.{jpg,png}; do
  # echo "$FILE"
  # mv "$FILE" "$IMAGE_DIR/doujin-pages"
# done

# matches:
# 10.jpg
# 12(2).jpg

# for FILE in "$HOME/mount/Internal storage/Download"/{[0-9][0-9],[0-9][0-9]\([0-9]\)}.{jpg,png}; do
  # echo "$FILE"
  # mv "$FILE" "$IMAGE_DIR/doujin-pages"
# done

if [ -d "$MOUNT_DIR/Internal storage" ] && [ -w "$MOUNT_DIR/Internal storage" ]; then
  echo "Android is mounted"
else
  echo "Android is not mounted, Aborting..."
  exit 1
fi

# Three directories/files per line
declare -a files=(
"$MOUNT_DIR/Internal storage/.File_Recycle"
"$MOUNT_DIR/Internal storage/.photoShare"
"$MOUNT_DIR/Internal storage/BES"
"$MOUNT_DIR/Internal storage/EMAScanner"
"$MOUNT_DIR/Internal storage/VeryFitPro"
"$MOUNT_DIR/Internal storage/RetroArch"
"$MOUNT_DIR/Internal storage/Pictures/.thumbnails"
"$MOUNT_DIR/Internal storage/Pictures/BearFace"
#"$MOUNT_DIR/Internal storage/Pictures/Screenshots"
"$MOUNT_DIR/Internal storage/Pictures/.Gallery2"
"$MOUNT_DIR/Internal storage/OSSLog"
"$MOUNT_DIR/Internal storage/OneSyncFiles"
"$MOUNT_DIR/Internal storage/DriveSyncFiles"
"$MOUNT_DIR/Internal storage/Movies"
"$MOUNT_DIR/Internal storage/Huawei"
)

for i in "${files[@]}"; do
  if [ -e "$i" ]; then
    echo "Removing $i"
    rm -rf "$i" > /dev/null 2>&1
  fi
done

for FILE in "$MOUNT_DIR/Internal storage/Pictures/Tachiyomi/"*; do
  echo "$FILE"
  mv "$FILE" "$IMAGE_DIR/doujin-pages"
done

declare -a dir_list=(
"$MOUNT_DIR/Internal storage/Download"
"$MOUNT_DIR/Internal storage/Pictures/Boost"
)

sh "$HOME/.bin/sort-files.sh" "${dir_list[@]}"
