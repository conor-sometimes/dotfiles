#!/usr/bin/env bash

yinit

while true; do
  echo "which host do you want to log onto?"
  echo "1)  tool1.ops"
  echo "2)  site.ops"
  echo "3)  tool1.loz"
  echo "4)  tftp1.ops"
  echo "5)  netops2.corp.gq1"
  echo "6)  tool1.ops.corp"
  echo "7)  lotr.netops.corp"
  echo "8)  tftp1.ops.bfr"
  echo "9)  admin1.ops.ir2"
  echo "10) node01-disksan1.ops.ir2"
  echo ""
  echo "0)  exit"
  echo ""
  echo "Selection:"

  read -r -n 1 SELECTION
  case $SELECTION in
    1 ) ssh tool1.ops.ir2.yahoo.com ;;
    2 ) ssh -A site.ops.corp.yahoo.com ;;
    3 ) ssh tool1.ops.loz.yahoo.com ;;
    4 ) ssh tftp1.ops.ir2.yahoo.com ;;
    5 ) ssh netops2.corp.gq1.yahoo.com  ;;
    6 ) ssh tool1.ops.corp.yahoo.com ;;
    7 ) ssh lotr.netops.corp.gq1.yahoo.com ;;
    8 ) ssh -t tool1.ops.corp.yahoo.com ssh -t tftp1.ops.bfr.yahoo.com ;;
    9 ) ssh admin1.ops.ir2.yahoo.com ;;
    10 )ssh node01-disksan1.ops.ir2.yahoo.com ;;
    q | 0 ) exit 1;;
    * )
  esac
done
