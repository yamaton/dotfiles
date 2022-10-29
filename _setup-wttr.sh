#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

mkdir -p ~/.local/bin
curl https://wttr.in/:bash.function > ~/.local/bin/wttr
chmod +x ~/.local/bin/wttr
