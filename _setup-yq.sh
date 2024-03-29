#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=yq

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq -r '.versions.stable')"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 4 | cut -d v -f 2)"
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
    elif [[ "$(uname -s)" == "Linux" ]]; then
        case "$(uname -m)" in
            "x86_64")  readonly FILE="yq_linux_amd64" ;;
            "armv6l")  readonly FILE="yq_linux_arm" ;;
            "armv7l")  readonly FILE="yq_linux_arm" ;;
            "aarch64") readonly FILE="yq_linux_arm64" ;;
        esac
        readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/${FILE}"
        wget -N "$URI"
        mkdir -p "$HOME"/.local/bin && mv -f ./"$FILE" "$HOME"/.local/bin/yq
        chmod +x "$HOME"/.local/bin/yq
    fi
fi
