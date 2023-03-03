#!/usr/bin/env bash
#
# polybar_functions.sh
#
# Copyright (C) 2021 dindybutts
#
# Distributed under terms of the GPLv3 license.
#

update_check() {

  UPDATE_COUNT="$(checkupdates | wc -l)"
  case $? in
    0)
      if [ "$UPDATE_COUNT" -eq "1" ]; then
        echo "$UPDATE_COUNT Update available!"
      elif [ "$UPDATE_COUNT" -gt "1" ]; then
        echo "$UPDATE_COUNT Updates available!"
      fi
      ;;
    2)
      echo "No updates available"
      ;;
  esac

}

# Only check if we're not in Ireland
# I'd like to think I know where I currently am.
vpn_country() {

  COUNTRY=$(curl -s "https://am.i.mullvad.net/country")
  if [[ $COUNTRY != "Ireland" ]]; then
    echo "VPN: $COUNTRY"
  fi

}

# this is a test
panel_test() {
  echo "hello"
}

"$1"
