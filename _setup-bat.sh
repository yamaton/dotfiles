#!/usr/bin/env bash

CMD=bat

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d ' ' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "Current version is the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "Update available: ${VERSION} (current ${CURRENT})"
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ -x "$(command -v apt)" ]; then
        if [ "$(uname -m)" == "x86_64" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-musl_${VERSION}_amd64.deb"

        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_armhf.deb"
        fi
        wget -N "$URI"
        FILE=$(basename "$URI")
        sudo apt install ./"$FILE"
        rm -f ./"$FILE"
    fi
fi
