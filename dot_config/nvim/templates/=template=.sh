#!/usr/bin/env bash
#
# %FFILE%
#
# Copyright (C) %YEAR% %USER% <%MAIL%>
#
# Distributed under terms of the %LICENSE% license.

set -o errexit
set -o nounset
set -o pipefail

help() {
    echo "Usage: $(basename $0) [-h] [-f filename]"
    echo -e "\t-h\t\tDisplay this help message and exit"
    echo -e "\t-f filename\tSpecify a filename to process"
}

%HERE%
