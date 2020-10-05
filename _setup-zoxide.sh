#!/usr/bin/env bash

readonly NAME=zoxide

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
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URI="https://github.com/ajeetdsouza/zoxide/releases/download/v${VERSION}/${NAME}-x86_64-unknown-linux-musl"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/ajeetdsouza/zoxide/releases/download/v${VERSION}/${NAME}-armv7-unknown-linux-musleabihf"
        fi
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        chmod +x ./"$FILE"
        rm -rf ~/bin/zoxide
        mv ./"$FILE" ~/bin/zoxide
    fi
fi
