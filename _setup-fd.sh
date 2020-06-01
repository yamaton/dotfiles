#!/usr/bin/env bash

CMD=fd

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d ' ' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -p "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ] || [[ "$confirm" == [yY] ]]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "${CMD}"
    elif [ "$(uname -s)" == "Linux" ]; then
        if [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v apt)" ]; then
            URI="https://github.com/sharkdp/fd/releases/download/v${VERSION}/fd-musl_${VERSION}_amd64.deb"
            wget -N "${URI}"
            sudo apt install "./$(basename "$URI")"
            rm -f "fd-musl_${VERSION}_amd64.deb"
        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/sharkdp/fd/releases/download/v${VERSION}/fd-v${VERSION}-arm-unknown-linux-musleabihf.tar.gz"
            wget -N "${URI}"
            NAME=$(basename "$URI")
            tar xzf "./${NAME}"
            rm "./${NAME}"
            echo "------"
            NAME1="${NAME%.*.*}"
            echo "$NAME1"
            [ ! -d ~/bin ] &&  mkdir ~/bin
            cp "${NAME1}/${CMD}" ~/bin
        fi
    fi
fi
