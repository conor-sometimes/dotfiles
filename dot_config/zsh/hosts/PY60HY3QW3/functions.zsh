#!/usr/bin/env zsh
#
# functions.zsh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

# ta tech "delete browser history"
ta() {
  if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "ta work \"Do stuff\""
    return 1
  fi
  if [[ -v $3 ]]; then
    task add +$1 $2 depends:$3
  else
    task add +$1 $2
  fi
}

add_tickets_to_task() {
  while IFS="," read -r TICKET HOST ISSUE LOCATION
do
  task add +tickets "$TICKET, $HOST, $ISSUE"
done <$HOME/tickets.csv
}

  # while read TICKET; do
    # task add +tickets "Fix ticket: $TICKET"
  # done <$HOME/tickets.txt
set_title() {
  echo -e "\033];${1}\007"
}
