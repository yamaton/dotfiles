#!/usr/bin/env bash

readonly CMD=go

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" version | cut -d ' ' -f3 | cut -c 3-)"
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
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
        readonly URI="https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz"
        cd ~/.local/bin || exit
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        rm -rf go golang
        tar xvf ./"$FILE"
        rm -f ./"$FILE"
        mv go golang
        ln -sf ~/.local/bin/golang/bin/go ~/.local/bin/go
        ln -sf ~/.local/bin/golang/bin/gofmt ~/.local/bin/gofmt
    fi
fi
