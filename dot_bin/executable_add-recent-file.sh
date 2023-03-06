#!/usr/bin/env bash
#
# add-recent-file.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

# $1 is the filename

set -o errexit
set -o nounset

DATE="$(date --iso-8601)T$(date +%H:%M:%S)Z"

sed -i '$ d' "$HOME"/.local/share/recently-used.xbel

echo -e "  <bookmark href=\"file://$1\" added=\"$DATE\" modified=\"$DATE\" visited=\"$DATE\">
    <info>
      <metadata owner=\"http://freedesktop.org\">
        <mime:mime-type type=\"image/png\"/>
        <bookmark:applications>
          <bookmark:application name=\"Firefox\" exec=\"&apos;firefox %u&apos;\" modified=\"$DATE\" count=\"1\"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
</xbel>" >> "$HOME"/.local/share/recently-used.xbel
