#!/usr/bin/env bash
#
# import-gpg-keys.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

case "$HOSTNAME" in
  "K9J507N7L0")
    KEY="macbook"
    TRUST="C59E2EA148098193BEEEE42087BFE2E84FE74F61:6:"
    ;;
  "hokkaido")
    KEY="server"
    TRUST="7032F7F9BC73C52B99956EB1F79E4AE90F072A31:6:"
    ;;
  "honshu")
    KEY="desktop"
    ;;
esac

REPO_DIR="$HOME/.local/share/chezmoi"

gpg --decrypt "$REPO_DIR/provision/gpg/encrypted_${KEY}.gpg.asc" | gpg --import
echo "$TRUST" | gpg --import-ownertrust
