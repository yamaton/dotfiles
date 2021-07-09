#!/usr/bin/env bash

readonly CMD=parallel

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f3)"
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
    else
        readonly URI="https://ftpmirror.gnu.org/parallel/parallel-latest.tar.bz2"
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        tar xvf ./"$FILE"
        (
        cd parallel-*/
        ./configure
        make -j "$(nproc)"
        sudo make install
        )
        rm -f ./"$FILE"
        rm -rf parallel-*/
    fi
fi
