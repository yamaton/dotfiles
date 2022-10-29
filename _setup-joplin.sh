#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

wget -qO - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
mkdir -p ~/.local/bin
ln -sf ~/.joplin/Joplin.AppImage ~/.local/bin/joplin
