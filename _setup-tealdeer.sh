#!/usr/bin/env bash

readonly NAME=tealdeer
readonly CMD=tldr

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
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
            "x86_64") FILE="tealdeer-linux-x86_64-musl" ;;
            "armv6l") FILE="tealdeer-linux-arm-musleabi" ;;
            "armv7l") FILE="tealdeer-linux-armv7-musleabihf" ;;
            *) FILE="" ;;
        esac
        URI="https://github.com/dbrgn/tealdeer/releases/download/v${VERSION}/${FILE}"
        wget -c -O tldr "$URI"
        chmod +x tldr
        mv tldr ~/.local/bin/

        URI="https://github.com/dbrgn/tealdeer/releases/download/v${VERSION}/completions_zsh"
        wget -c -O ~/.zfunc/_tldr "$URI"

        URI="https://github.com/dbrgn/tealdeer/releases/download/v${VERSION}/completions_fish"
        wget -c -O ~/.config/fish/completions/tldr.fish "$URI"

        ln -sf "${BASEDIR}/.config/${NAME}" "${HOME}/.config/"
    fi
fi
