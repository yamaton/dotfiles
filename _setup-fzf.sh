#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi
readonly CMD=fzf
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f1)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "${CMD}"
        "$(brew --prefix)"/opt/fzf/install
    elif [[ "$(uname -s)" == "Linux" ]]; then
        readonly URI="https://github.com/junegunn/fzf/archive/${VERSION}.tar.gz"
        rm -rf ~/.fzf && mkdir ~/.fzf
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        tar xvzf ./"$FILE" -C ~/.fzf
        rm -f "$FILE"
        ~/.fzf/"fzf-${VERSION}"/install
    fi
fi
