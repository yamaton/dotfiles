#!/usr/bin/env bash

readonly CMD=topgrade

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
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URL="https://github.com/r-darwish/topgrade/releases/download/v${VERSION}/topgrade-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/r-darwish/topgrade/releases/download/v${VERSION}/topgrade-v${VERSION}-armv7-unknown-linux-gnueabihf.tar.gz"
        else
            if [[ ! -x "$(command -v cargo)" ]]; then
                BASEDIR="$(dirname "$(readlink -f "$0")")"
                readonly BASEDIR
                source "${BASEDIR}/setup-rust-and-cargo.sh"
            fi
            cargo install "$CMD"
            exit 0
        fi

        wget -N "$URL"
        FILE="$(basename "$URL")"
        readonly FILE
        tar xvf "$FILE"
        rm -f "$FILE"
        mv -f ./topgrade "${HOME}/bin/"
    fi
fi
