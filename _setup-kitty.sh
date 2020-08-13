#!/usr/bin/env bash

readonly CMD=kitty
VERSION="$(curl --silent https://formulae.brew.sh/api/cask/${CMD}.json | jq .version | tr -d \")"
readonly VERSION
BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
readonly KITTY_CONF_DIR=~/.config/kitty


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
    if [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
        mkdir ~/
        git clone --depth 1 git@github.com:dexpota/kitty-themes.git "${KITTY_CONF_DIR}/kitty-themes"
        ln -sf "${BASEDIR}/.config/kitty/kitty.conf" "$KITTY_CONF_DIR"
        mkdir -p ~/.terminfo/x/
        cp ~/.local/kitty.app/share/terminfo/x/xterm-kitty ~/.terminfo/x/
    fi
fi