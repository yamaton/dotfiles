#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=kitty
VERSION="$(curl --silent https://formulae.brew.sh/api/cask/${CMD}.json | jq -r '.version')"
readonly VERSION
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
readonly KITTY_CONF_DIR=~/.config/kitty
readonly KITTY_HOME=~/.local/kitty.app


if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
        mkdir -p ~/.local/bin
        ln -sf "${KITTY_HOME}/bin/kitty" ~/.local/bin/
        [[ ! -d "${KITTY_CONF_DIR}/kitty-themes" ]] && git clone --depth 1 git@github.com:dexpota/kitty-themes.git "${KITTY_CONF_DIR}/kitty-themes"
        ln -sf "${BASEDIR}/.config/kitty/kitty.conf" "$KITTY_CONF_DIR"
        cp "$KITTY_HOME/share/applications/kitty.desktop" ~/.local/share/applications
        sed -i "s|Icon=kitty|Icon=$KITTY_HOME/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
        mkdir -p ~/.terminfo/x/
        cp "${KITTY_HOME}/share/terminfo/x/xterm-kitty" ~/.terminfo/x/
    fi
fi