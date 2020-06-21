#!/usr/bin/env bash

CMD=syncthing

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d' ' -f2 | cut -d'v' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -p "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ] || [[ "$confirm" == [yY] ]]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ "$(uname -s)" == "Linux" ]; then
        if [ "$(uname -m)" == "x86_64" ]; then
            ARCH="amd64"
        elif [ "$(uname -m)" == "armv7l" ]; then
            ARCH="arm"
        fi
        URI="https://github.com/syncthing/syncthing/releases/download/v${VERSION}/syncthing-linux-${ARCH}-v${VERSION}.tar.gz"
        wget -N "$URI"
        FILE=$(basename "$URI")
        DIR="${FILE%.tar.gz}"
        tar xf ./"$FILE"
        rm "$FILE"
        mkdir -p ~/bin
        rm -rf ~/bin/"$DIR"
        mv -f ./"$DIR" ~/bin/"$DIR"
        rm -f ~/bin/"$CMD"
        ln -s "$HOME/bin/$DIR/$CMD" ~/bin
    fi
fi
