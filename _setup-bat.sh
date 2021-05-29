#!/usr/bin/env bash

readonly CMD=bat

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

mkdircp () {
    mkdir -p "$2" && cp -f "$1" "$2"
}

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
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
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URL="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URL="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
        fi
        wget -N "$URL"
        FILE="$(basename "$URL")"
        readonly FILE
        tar -xvf "$FILE"
        DIR="${FILE%.*.*}"
        (
            cd "$DIR" || exit
            mkdir -p ~/.zfunc && cp -f autocomplete/bat.zsh ~/.zfunc/_bat
            mkdircp autocomplete/"${CMD}.fish" ~/.config/fish/completions/
            mkdircp "${CMD}" ~/bin/
            mkdircp "${CMD}.1" ~/.local/share/man/man1/
        )
        mandb ~/.local/share/man/
        rm -rf "$DIR" "$FILE"
    fi
fi
