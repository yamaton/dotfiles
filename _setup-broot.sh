#!/usr/bin/env bash

NAME=broot
CMD=br

if [ -x "$(command -v ${NAME})" ]; then
    VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")
    CURRENT=$("$NAME" --version | cut -d ' ' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "Current version is the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "Update available: ${VERSION} (current ${CURRENT})"
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${NAME})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$NAME"
    elif [ -x "$(command -v apt)" ] && [ "$(uname -m)" == "x86_64" ]; then
        URI="https://github.com/Canop/$NAME/releases/download/v$VERSION/$NAME"
        mkdir -p ~/bin && cd ~/bin
        wget -N "$URI"
        chmod +x ./"$NAME"
    fi
    "$NAME" --install
fi
