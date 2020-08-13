#!/usr/bin/env bash

readonly CMD=bat

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
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-musl_${VERSION}_amd64.deb"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_armhf.deb"
        fi
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        sudo apt install ./"$FILE"
        rm -f ./"$FILE"
    fi
fi
