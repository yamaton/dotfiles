#!/usr/bin/env bash

readonly CMD=rga
readonly NAME="ripgrep-all"

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v $CMD)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            arch="x86_64"
            uri="https://github.com/phiresky/ripgrep-all/releases/download/v${VERSION}/ripgrep_all-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]] || [[ "$(uname -m)" == "armv8" ]]; then
            arch="arm"
            uri="https://github.com/phiresky/ripgrep-all/releases/download/v${VERSION}/ripgrep_all-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
        else
            echo "Unsupported architecture? $(uname -s)"
            echo "    Exiting..."
            exit 0
        fi
        wget -N "$uri"
        filename="$(basename "$uri")"
        dir="${filename%.tar.gz}"
        tar xvf ./"$filename"
        cp -f "${dir}/rga" ~/bin/
        cp -f "${dir}/rga-preproc" ~/bin/
        rm -f ./"$filename"
        rm -rf "${dir}"
    fi
fi
