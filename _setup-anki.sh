#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=anki

VERSION="$(curl --silent https://formulae.brew.sh/api/cask/${CMD}.json | jq '.version' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install --cask "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
         readonly URI="https://github.com/ankitects/anki/releases/download/${VERSION}/anki-${VERSION}-linux.tar.bz2"
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        tar -xvf ./"$FILE"
        DIR="${FILE%.*.*}"
        readonly DIR
        cd "$DIR"
        sudo ./install.sh
        cd ..
        rm -f "$FILE"
        rm -rf "$DIR"
    else
        echo "Unavailable for $(uname -m)"
    fi
fi
