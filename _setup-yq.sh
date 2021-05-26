#!/usr/bin/env bash

readonly CMD=yq

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 3)"
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
            readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/yq_linux_amd64"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/yq_linux_arm"
        fi
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        mkdir -p "$HOME"/bin && mv -f ./"$FILE" "$HOME"/bin/yq
        chmod +x "$HOME"/bin/yq
    fi
fi
