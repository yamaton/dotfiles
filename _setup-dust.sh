#!/usr/bin/env bash

readonly CMD=dust

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
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
            readonly URI="https://github.com/bootandy/dust/releases/download/v${VERSION}/${CMD}-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
            wget -N "${URI}"
            NAME="$(basename "$URI")"
            readonly NAME
            tar xzf "./${NAME}"
            rm "./${NAME}"
            readonly NAME1="${NAME%.*.*}"
            echo "$NAME1"
            mkdir -p ~/.local/bin
            cp -f "${NAME1}/${CMD}" ~/.local/bin
            rm -rf "$NAME1"
    else
        echo "Unsupported. Exiting..."
        exit 0
    fi
fi
