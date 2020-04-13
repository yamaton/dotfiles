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
        echo "Current version is the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "Update available: ${VERSION} (current ${CURRENT})"
    fi
fi

## [TODO] add appimage version once it works
if [ "$1" = "-f" ] || [ ! -x "$(command -v nvim)" ]; then

    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$NAME"
    elif [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v apt)" ]; then
        URI="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"

        mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
        wget -N "$URI"
        chmod +x ./nvim.appimage
        sudo apt install -y fuse
        [ -L ./nvim ] && rm -f ./nvim
        sudo rm -f /usr/local/bin/nvim
        sudo ln -s ./nvim.appimage /usr/local/bin/nvim
    elif [ "$(uname -m)" != "x86_64" ] && [ -x "$(command -v apt)" ]; then
        sudo apt install --no-install-recommends -y neovim
    fi

    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p "$CONFIG_DIR"
    cp "$BASEDIR"/init.vim "$CONFIG_DIR"
else
    echo "[INFO] skipping; neovim is already available"
fi
