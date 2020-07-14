#!/usr/bin/env bash

readonly CMD=syncthing

VERSION="$(curl curl --silent https://formulae.brew.sh/api/cask/syncthing.json | jq '.version' | tr -d \" | cut -d '-' -f1)"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d' ' -f2 | cut -d'v' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly ARCH="amd64"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly ARCH="arm"
        fi
        readonly URI="https://github.com/syncthing/syncthing/releases/download/v${VERSION}/syncthing-linux-${ARCH}-v${VERSION}.tar.gz"
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        readonly DIR="${FILE%.tar.gz}"
        tar xf ./"$FILE"
        rm "$FILE"
        mkdir -p ~/bin
        rm -rf ~/bin/"$DIR"
        mv -f ./"$DIR" ~/bin/"$DIR"
        rm -f ~/bin/"$CMD"
        ln -s "$HOME/bin/$DIR/$CMD" ~/bin
    fi
fi
