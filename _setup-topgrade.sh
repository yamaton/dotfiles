#!/usr/bin/env bash

readonly NAME=topgrade

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $NAME)" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${NAME} ${CURRENT}"
    else
        echo "${NAME} ${VERSION} is available: (current ${NAME} ${CURRENT})"
        read -rp "Upgrade to ${NAME} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${NAME})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URL="https://github.com/r-darwish/topgrade/releases/download/v${VERSION}/topgrade-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/r-darwish/topgrade/releases/download/v${VERSION}/topgrade-v${VERSION}-armv7-unknown-linux-gnueabihf.tar.gz"
        else
            if [[ ! -x "$(command -v cargo)" ]]; then
                read -rp "Install cargo and rust? (y/N): " confirm
                if [[ "$confirm" == [yY] ]]; then
                    BASEDIR="$(dirname "$(readlink -f "$0")")"
                    readonly BASEDIR
                    source "${BASEDIR}/setup-rust-and-cargo.sh"
                else
                    echo "Exit without installing ${NAME}"
                    exit 0
                fi
            fi
            cargo install "$NAME"
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
