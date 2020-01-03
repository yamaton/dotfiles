#!/usr/bin/env bash

NAME=ripgrep
CMD=rg
VERSION=$(curl --silent https://formulae.brew.sh/api/formula-linux/${NAME}.json | jq '.versions.stable' | tr -d \")
CURRENT=$("$CMD" --version | head -1 | cut -d ' ' -f2)
if [ -x "$(command -v $CMD)" ] && [ $VERSION == $CURRENT ]; then
    echo "Current version is the latest: ${CMD} ${CURRENT}"
    exit 1
else
    echo "Update available: ${VERSION} (current ${CURRENT})"
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
