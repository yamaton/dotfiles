#!/usr/bin/env bash

readonly CMD=croc

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 3 | cut -d '-' -f 1 | cut -d v -f 2)"
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
            readonly URL="https://github.com/schollz/croc/releases/download/v${VERSION}/croc_${VERSION}_Linux-64bit.deb"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/schollz/croc/releases/download/v${VERSION}/croc_${VERSION}_Linux-ARM.deb"
        fi
        wget -N "$URL"
        FILE="$(basename "$URL")"
        readonly FILE
        sudo apt install ./"$FILE"
        rm -rf "$FILE"
    fi
fi
