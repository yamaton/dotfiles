#!/usr/bin/env bash

readonly AUTHOR=dduan
readonly CMD=tre
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

VERSION="$(./get-version-github.sh "${AUTHOR}/${CMD}")"
readonly VERSION

mkdirmv () {
    mkdir -p "$2" && mv -f "$1" "$2"
}

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version)"
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
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        case "$(uname -m)" in
            "x86_64")  readonly FILE="${CMD}-v${VERSION}-x86_64-unknown-linux-musl.tar.gz" ;;
            "armv7l")  readonly FILE="${CMD}-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz" ;;
        esac
        wget -N "$URL"
        tar -xvf "$FILE"
        mkdirmv "${CMD}" ~/.local/bin
        mkdirmv "${CMD}.1" ~/.local/bin
        rm -rf "$FILE"
    fi
fi
