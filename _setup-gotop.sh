#!/usr/bin/env bash

CMD="gotop"
VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version)
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
    else
        if [ "$(uname -m)" == "x86_64" ]; then
            ARCH="amd64"
        elif [ "$(uname -m)" == "armv7l" ]; then
            ARCH="arm7"
        fi

        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        URI="https://github.com/cjbassi/${CMD}/releases/download/${VERSION}/${CMD}_${VERSION}_${OS}_${ARCH}.tgz"
        curl -L "${URI}" | tar xzf -
        [ ! -d ~/bin ] && mkdir ~/bin
        mv "${CMD}" ~/bin
    fi
fi
