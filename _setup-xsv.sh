#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly NAME=xsv
readonly CMD="$NAME"

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq -r '.versions.stable')"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v $CMD)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]] && [[ "$(command -v apt)" ]]; then
            readonly URI="https://github.com/BurntSushi/${NAME}/releases/download/${VERSION}/${NAME}-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
            wget -N "$URI"
            FILE="$(basename "$URI")"
            readonly FILE
            mv -f "$CMD" ~/.local/bin/
            rm -rf "$FILE"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/BurntSushi/${NAME}/releases/download/${VERSION}/${NAME}-${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
            wget -N "$URI"
            FILE="$(basename "$URI")"
            readonly FILE
            mv -f "$CMD" ~/.local/bin/
            rm -rf "$FILE"
        elif [[ "$(command -v apt)" ]]; then
            sudo apt install "$NAME" -y
        fi
    fi
fi
