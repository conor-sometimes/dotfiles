#!/usr/bin/env bash
#
# import-gpg-keys.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

readonly HOST_DESKTOP="honshu"
readonly HOST_SERVER="hokkaido"
readonly HOST_MACBOOK="PY60HY3QW3"

readonly REPO_DIR="$HOME/.local/share/chezmoi"

KEY=""
TRUST=""

case "$(hostname)" in
  $HOST_MACBOOK)
    echo "Macbook"
    KEY="macbook"
    TRUST="C59E2EA148098193BEEEE42087BFE2E84FE74F61:6:"
    ;;
  $HOST_SERVER)
    echo "Server"
    KEY="server"
    TRUST="7032F7F9BC73C52B99956EB1F79E4AE90F072A31:6:"
    ;;
esac


gpg --decrypt "$REPO_DIR/provision/gpg/${KEY}-private-key.gpg.asc" | gpg --import
echo "$TRUST" | gpg --import-ownertrust
