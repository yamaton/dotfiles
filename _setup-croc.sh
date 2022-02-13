#!/usr/bin/env bash

readonly CMD=croc

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 3 | cut -d '-' -f 1 | cut -d v -f 2)"
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
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        case "$(uname -m)" in
            "x86_64") readonly FILE="croc_${VERSION}_Linux-64bit.deb" ;;
            "armv7l") readonly FILE="croc_${VERSION}_Linux-ARM.deb" ;;
            "aarch64") readonly FILE="croc_${VERSION}_Linux-ARM64.deb" ;;
        esac
        readonly URL="https://github.com/schollz/croc/releases/download/v${VERSION}/${FILE}"
        wget -N "$URL"
        sudo apt install ./"$FILE"
        rm -rf "$FILE"
    fi
fi
