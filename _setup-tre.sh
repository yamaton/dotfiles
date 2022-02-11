#!/usr/bin/env bash

readonly AUTHOR=dduan
readonly CMD=tre
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

VERSION="$(./get-version-github.sh "${AUTHOR}/${CMD}")"
readonly VERSION

mkdirmv () {
    mkdir -p "$2" && mv -f "$1" "$2"
}

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version)"
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
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URL="https://github.com/${AUTHOR}/${CMD}/releases/download/v${VERSION}/${CMD}-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/${AUTHOR}/${CMD}/releases/download/v${VERSION}/${CMD}-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
        fi
        wget -N "$URL"
        FILE="$(basename "$URL")"
        readonly FILE
        tar -xvf "$FILE"
        mkdirmv "${CMD}" ~/.local/bin
        mkdirmv "${CMD}.1" ~/.local/bin
        rm -rf "$FILE"
    fi
fi
