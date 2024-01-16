#!/usr/bin/env bash
#
# find_server.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.


# check if user has arp-scan installed
if ! [ -x "$(command -v arp-scan)" ]; then
  echo 'Error: arp-scan is not installed.' >&2
  exit 1
fi

IP_ADDRESS=$(sudo arp-scan --localnet --interface=enp4s0 --plain | awk '/a8:a1:59:04:c2:34/ {print $1}')

echo "${IP_ADDRESS}"
echo "ssh conor@${IP_ADDRESS} -p 3663"
