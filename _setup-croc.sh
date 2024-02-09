#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=croc

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq -r '.versions.stable')"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f 3 | cut -d '-' -f 1 | cut -d v -f 2)"
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
            "x86_64") readonly FILE="${CMD}_v${VERSION}_Linux-64bit.tar.gz" ;;
        esac
        readonly URL="https://github.com/schollz/croc/releases/download/v${VERSION}/${FILE}"
        wget -N "$URL"
        tar -xvf "$FILE"
        mv croc ~/.local/bin
        rm -rf "$FILE"
        rm -f README.md LICENSE
        mkdir -p "$HOME/.config/bash_completion"
        mkdir -p "$HOME/.config/zsh/completions"
        mv -f bash_autocomplete "$HOME/.config/bash_completion/croc"
        mv -f zsh_autocomplete "$HOME/.config/zsh/completions/_croc"
    fi
fi
