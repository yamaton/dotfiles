#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=grex

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq -r '.versions.stable')"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
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
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URI="https://github.com/pemistahl/grex/releases/download/v${VERSION}/${CMD}-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
            wget -N "${URI}"
            NAME="$(basename "$URI")"
            readonly NAME
            tar -xvf "./${NAME}"
            rm "./${NAME}"
            [[ ! -d ~/.local/bin ]] && mkdir ~/.local/bin
            mv -f "./${CMD}" ~/.local/bin/
    else
        echo "Unsupported. Exiting..."
        exit 0
    fi
fi
