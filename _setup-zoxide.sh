#!/usr/bin/env bash

readonly NAME=zoxide

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $NAME)" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2 | cut -c 2-)"
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
            readonly URI="https://github.com/ajeetdsouza/zoxide/releases/download/v${VERSION}/${NAME}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/ajeetdsouza/zoxide/releases/download/v${VERSION}/${NAME}-armv7-unknown-linux-musleabihf.tar.gz"
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
        wget -N "$URI"
        FILE="$(basename "$URI")"
        tar -xvf "$FILE"
        rm -f "$FILE"
        readonly DIRNAME="${FILE%.*.*}"
        mkdir -p ~/.local/bin
        mv "${DIRNAME}/${NAME}" ~/.local/bin/

        # save man files
        mkdir -p ~/.local/share/man/man1
        mv "${DIRNAME}"/man/*.1 ~/.local/share/man/man1
        mandb ~/.local/share/man

    fi
fi
