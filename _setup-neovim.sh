#!/usr/bin/env bash

NAME=neovim
CMD=nvim

BASEDIR=$(dirname "$(readlink -f "$0")")
REPO_DIR="${HOME}/confs"
BIN_DIR="${HOME}/bin"
CONFIG_DIR="${HOME}/.config/$CMD"

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | head -1 | cut -d ' ' -f2 | cut -d'v' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -p "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi


if [ "$1" = "-f" ] || [ ! -x "$(command -v nvim)" ] || [[ "$confirm" == [yY] ]]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$NAME"
    elif [ "$(uname -m)" == "x86_64" ] && [ "$(uname -s)" == "Linux" ]; then
        URI="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"

        mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
        wget -N "$URI"
        chmod +x ./nvim.appimage
        sudo apt install -y fuse
        [ -L ./nvim ] && rm -f ./nvim
        sudo rm -f /usr/local/bin/nvim
        sudo ln -s "${BIN_DIR}/nvim.appimage" /usr/local/bin/nvim
    elif [ "$(uname -m)" != "x86_64" ] && [ -x "$(command -v apt)" ]; then
        sudo apt install --no-install-recommends -y neovim
    fi

    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p "$CONFIG_DIR"
    [ -f "$CONFIG_DIR"/init.vim ] && mv "$CONFIG_DIR"/init.vim "$CONFIG_DIR"/init.vim.backup
    ln -s "$BASEDIR"/init.vim "$CONFIG_DIR"

    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
    ln -s "$BASEDIR"/.vimrc ~
fi
