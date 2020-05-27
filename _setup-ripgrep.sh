#!/usr/bin/env bash

NAME=ripgrep
CMD=rg

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | head -1 | cut -d ' ' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v $CMD)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$NAME"
    else
        if [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v apt)" ]; then
            URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep_${VERSION}_amd64.deb"
            wget -N "${URI}"
            sudo apt install "./ripgrep_${VERSION}_amd64.deb"
            rm -f "./ripgrep_${VERSION}_amd64.deb"
        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
            curl -L "${URI}" | tar xzf -
            cp "ripgrep-${VERSION}-arm-unknown-linux-gnueabihf/rg" ~/bin
        fi
    fi
fi
