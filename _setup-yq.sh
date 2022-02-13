#!/usr/bin/env bash

readonly CMD=yq

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 4)"
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
        case "$(uname -m)" in
            "x86_64") FILE="yq_linux_amd64" ;;
            "armv6l") FILE="yq_linux_arm" ;;
            "armv7l") FILE="tealdeer-linux-armv7-musleabihf" ;;
            *) FILE="" ;;
        esac
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/${FILE}"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/${FILE}"
        elif [[ "$(uname -m)" == "aarch64" ]]; then
            readonly URI="https://github.com/mikefarah/yq/releases/download/v${VERSION}/${FILE}"
        fi
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        mkdir -p "$HOME"/.local/bin && mv -f ./"$FILE" "$HOME"/.local/bin/yq
        chmod +x "$HOME"/.local/bin/yq
    fi
fi
