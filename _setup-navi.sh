#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=navi

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URL="https://github.com/denisidoro/navi/releases/download/v${VERSION}/navi-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/denisidoro/navi/releases/download/v${VERSION}/navi-v${VERSION}-armv7-unknown-linux-musleabihf.tar.gz"
        fi
        wget -N "$URL"
        FILE="$(basename "$URL")"
        readonly FILE
        tar -xvf "$FILE"
        mkdircp "$CMD" ~/.local/bin
        rm -rf "$FILE"
    fi
fi
