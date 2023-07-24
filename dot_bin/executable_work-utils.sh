#!/usr/bin/env bash
#
# work-utils.sh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

function switch_utils() {
  echo "What's the network device hostname?"
  read -r HOSTNAME
  case $1 in
    ssh)
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}"
      ;;
    show)
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show mac address-table"
      ;;
    interface)
      echo "What port?"
      read -r -n 1 PORT
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show interface Ethernet${1}"
      ;;
  esac
}

function retire_utils() {
  TEMP_DIR=$(mktemp)
  nvim $TEMP_DIR/ytags
  if [[ -f $TEMP_DIR/ytags ]]; then
    scp $TEMP_DIR/ytags site.ops.corp.yahoo.com
  fi

  echo "What are we doing today?"
  echo -e "\t 1)  Show all mac addresses"
  echo -e "\t 2)  Check interface status"
  read -r OPERATION
  case $OPERATION in
    1)
    ssh site.ops.corp.yahoo.com "opsFind -q -f \"ytag sku_name serialno model\" ytags"
      ;;
    2)
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show mac address-table"
      ;;
    3)
      echo "What port?"
      read -r -n 1 PORT
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show interface Ethernet${1}"
      ;;
  esac
}

echo "What are we doing today?"
echo "1)  Network devices"
echo "2) Retires"
echo -e "\t 2a)  Check interface status"
echo ""
echo "0)  exit"
echo ""
echo "Selection:"

read -r -n 2 SELECTION
case $SELECTION in
  1 ) switch_utils ssh ;;
  1a ) switch_utils show ;;
  1b ) switch_utils interface ;;
  q | 0 ) exit 1;;
  * )
esac
