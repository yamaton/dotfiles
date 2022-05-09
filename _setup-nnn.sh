#!/usr/bin/env bash

# * Usage
# Run `./_setup-nnn.sh <repo-root>`
# Then it will clone nnn under <repo-root> and install it.

readonly CMD=nnn
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$($CMD -V)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

readonly REPO_DIR="${HOME}/confs"
mkdir -p "$REPO_DIR"

if [[ "$1" == "-f" ]] || [[ ! "$(command -v nnn)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
        readonly URI="https://github.com/jarun/nnn/releases/download/v${VERSION}/nnn-static-${VERSION}.x86_64.tar.gz"
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        tar -xvf ./"$FILE"
        mv -f nnn-static ~/.local/bin/nnn
        rm -f "$FILE"
    else
        echo "${CMD}: Unavailable for $(uname -m)"
    fi
fi
