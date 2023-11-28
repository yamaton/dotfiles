#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly NAME=ripgrep
readonly CMD=rg

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
            URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep_${VERSION}-1_amd64.deb"
            readonly URI
            wget -N "$URI"
            file="$(basename "$URI")"
            sudo apt install "./$file" -y
            rm -f "./$file"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
            curl -L "$URI" | tar -xzf -
            DIR="$(basename "$URI")"
            readonly DIR
            mv -f "${DIR}/rg" ~/.local/bin/
            rm -rf "ripgrep-${VERSION}-arm-unknown-linux-gnueabihf"
        elif [[ "$(command -v apt)" ]]; then
            sudo apt install ripgrep -y
        fi
    fi
fi
