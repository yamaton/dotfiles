#!/usr/bin/env bash

CMD=bat
VERSION=$(curl https://formulae.brew.sh/api/formula-linux/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ -x "$(command -v apt)" ]; then
        if [ "$(uname -m)" == "x86_64" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_amd64.deb"

        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_armhf.deb"
        fi
        wget -N "$URI"
        FILE=$(basename "$URI")
        sudo apt install "$FILE"
        rm -f "$FILE"
    fi
fi
