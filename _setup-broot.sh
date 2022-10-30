#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly NAME=broot
readonly CMD=br
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION
readonly ZIPFILE="broot_$VERSION.zip"

if [[ "$(command -v ${NAME})" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v ${NAME})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
        readonly URI="https://github.com/Canop/$NAME/releases/download/v$VERSION/$ZIPFILE"
        mkdir -p ~/.local/bin/"$NAME"_"$VERSION" && cd ~/.local/bin/"$NAME"_"$VERSION"
        wget -N "$URI"
        rm -rf build/*
        unzip "$ZIPFILE"
        rm -f "$ZIPFILE"
        thisdir="x86_64-unknown-linux-musl"
        echo "thisdir=$thisdir"
        chmod +x "$thisdir/$NAME"
        cp -f "$thisdir/$NAME" ..
        mkdir -p ~/.local/share/man/man1
        cp -f "./broot.1" ~/.local/share/man/man1
        mandb ~/.local/share/man
        cd ..
        rm -rf "$NAME"_"$VERSION"
    fi
fi
