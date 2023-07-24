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
  echo "What's the hostname?"
  read -r HOSTNAME

  echo "What are we doing today?"
  echo -e "\t 1) SSH into $HOSTNAME"
  echo -e "\t 2) Show all MAC Addresses on $HOSTNAME"
  echo -e "\t 3) Get status of interface on $HOSTNAME"
  case $1 in
    1)
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}"
      ;;
    2)
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show mac address-table"
      ;;
    3)
      echo "What port?"
      read -r -n 1 PORT
      ssh -A -J tool1.ops.ir2.yahoo.com "${HOSTNAME}" "show interface Ethernet${PORT}"
      ;;
    4)
      echo "get psu status"
      ;;
  esac
}

function retire_utils() {
  TEMP_DIR=$(mktemp)
  #gdate is mac specific, add os checking maybe?
  FILENAME="ytags-$(gdate --iso-8601)"
  nvim "$TEMP_DIR/$FILENAME"
  if [[ -f "$TEMP_DIR/$FILENAME" ]]; then
    scp "$TEMP_DIR/$FILENAME" "cmcshane@site.ops.corp.yahoo.com:~/ytags/$FILENAME"
  fi

  echo "What are we doing today?"
  echo -e "\t 1) Get SKU, Serial, and Model for belmont shipment"
  echo -e "\t 2) Remove Parent from ytags"
  echo -e "\t 3) Set ytags as destroyed in opsdb"
  read -r OPERATION
  case $OPERATION in
    1)
      ssh site.ops.corp.yahoo.com "opsFind -q -f \"ytag sku_name serialno model\" ~/ytags/$FILENAME"
      ;;
    2)
      ssh site.ops.corp.yahoo.com "/home/rcarroll/scripts/nuke_parent ~/ytags/$FILENAME"
      ;;
    3)
      ssh site.ops.corp.yahoo.com "/home/rcarroll/scripts/opsfind_set $FILENAME status \'destroyed\'"
      ;;
  esac
}

function host_utils() {
  # check raid battery
  # check fan status
  # check sel log
  # check uptime
  # check mce
}

echo "##########################################"
echo "# Yell at @cmshane if this stops working #"
echo "##########################################"

echo "What are we doing today?"
echo "1) Network device"
echo "2) Retires"
echo "3) Hosts"
echo ""
echo "0)  exit"
echo ""
echo "Selection:"

read -r -n 1 SELECTION
case $SELECTION in
  1 ) switch_utils;;
  2 ) retire_utils;;
  3 ) host_utils;;
  q | 0 ) exit 1;;
  * )
esac
