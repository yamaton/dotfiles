#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=parallel

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f3)"
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
