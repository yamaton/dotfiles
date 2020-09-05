#!/usr/bin/env bash

readonly NAME=tealdeer
readonly CMD=tldr

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2 | cut -d 'v' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${NAME} ${CURRENT}"
    else
        echo "${NAME} ${VERSION} is available: (current ${NAME} ${CURRENT})"
        read -rp "Upgrade to ${NAME} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
        ln -sf "${BASEDIR}/.config/${NAME}" "${HOME}/Library/Application Support/${NAME}"

    elif [[ "$(uname -s)" == "Linux" ]]; then
        case "$(uname -m)" in
            "x86_64") FILE="tldr-linux-x86_64-musl" ;;
            "armv6l") FILE="tldr-linux-arm-musleabi" ;;
            "armv7l") FILE="tldr-linux-armv7-musleabihf" ;;
            *) FILE="" ;;
        esac
        URI="https://github.com/dbrgn/tealdeer/releases/download/v${VERSION}/${FILE}"
        wget -cO tldr "$URI"
        chmod +x tldr
        mv tldr ~/bin/

        URI="https://github.com/dbrgn/tealdeer/releases/download/v${VERSION}/completions_zsh"
        wget -cO _tldr "$URI"
        sudo mv _tldr /usr/share/zsh/vendor-completions/_tldr
        ln -sf "${BASEDIR}/.config/${NAME}" "${HOME}/.config/"
    fi

fi
