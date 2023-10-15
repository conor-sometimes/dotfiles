#!/usr/bin/env bash
#
# polybar_functions.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.
#

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
