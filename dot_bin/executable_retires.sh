#!/usr/bin/env bash
#
# retires.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

function copy_ytag_file() {
  scp $1 "site.ops.corp.yahoo.com:ytags/$FILENAME"
}

echo "Pallet number:"
read -r PALLET_NUMBER
FILENAME="pallet-${PALLET_NUMBER}-$(date +%Y-%m-%d).txt"

nvim $FILENAME
echo $FILENAME

echo "Copying ytag file to ytags/$FILENAME"
copy_ytag_file "$FILENAME"

echo "1) opsFind OSTK"
echo "2) opsFind Belmont"
echo "3) opsFind_set 'destroyed'"

read -r SELECTION
case $SELECTION in
  1)
    ssh -A site.ops.corp.yahoo.com "opsFind -q -f \"ytag name site backplane locroom locarea locrow locrack locshelf type model eosl_date sku_name sku_config\" ytags/$FILENAME"
    ;;
  2)
    ssh -A site.ops.corp.yahoo.com "opsFind -q -f \"ytag sku_name serialno model\" ytags/$FILENAME"
    ;;
  3)
    ssh -A site.ops.corp.yahoo.com "/home/rcarroll/scripts/opsfind_set ytags/$FILENAME status \"destroyed\""
    ;;
esac
