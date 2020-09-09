#!/usr/bin/env bash

readonly CMD=fd

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
        brew install "${CMD}"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]] && [[ -x "$(command -v apt)" ]]; then
            readonly URI="https://github.com/sharkdp/fd/releases/download/v${VERSION}/fd-musl_${VERSION}_amd64.deb"
            wget -N "${URI}"
            sudo apt install "./$(basename "$URI")"
            rm -f "fd-musl_${VERSION}_amd64.deb"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/sharkdp/fd/releases/download/v${VERSION}/fd-v${VERSION}-arm-unknown-linux-musleabihf.tar.gz"
            wget -N "${URI}"
            NAME="$(basename "$URI")"
            readonly NAME
            tar xzf "./${NAME}"
            rm "./${NAME}"
            echo "------"
            readonly NAME1="${NAME%.*.*}"
            echo "$NAME1"
            [[ ! -d ~/bin ]] &&  mkdir ~/bin
            cp -f "${NAME1}/${CMD}" ~/bin/
            rm -rf "$NAME1"
        fi
    fi
fi
