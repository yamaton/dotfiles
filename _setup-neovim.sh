#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
REPO_DIR="${HOME}/confs"
BIN_DIR="${HOME}/bin"
CONFIG_DIR="${HOME}/.config/nvim"

## [TODO] add appimage version once it works
if [ "$1" = "-f" ] || [ ! -x "$(command -v nvim)" ]; then

    if [ $(uname -s) == "Darwin" ]; then
        brew install neovim
    elif [ $(uname -m) == "x86_64" ] && [ -x $(command -v apt) ]; then
        URI="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"

        [ ! -d "$BIN_DIR" ] && mkdir -p "$BIN_DIR"
        cd "$BIN_DIR"
        wget -N "$URI"
        chmod +x ./nvim.appimage
        sudo apt install fuse
        [ -L ./nvim ] && rm -f ./nvim
        ln -s ./nvim.appimage ./nvim
    elif [ $(uname -m) != "x86_64" ] && [ -x $(command -v apt) ]; then
        sudo apt install neovim
    fi

    [ ! -d "$REPO_DIR" ] && mkdir "$REPO_DIR"
    cd "$REPO_DIR"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    [ ! -d "$CONFIG_DIR" ] && mkdir -p "$CONFIG_DIR"
    cp "$BASEDIR"/init.vim "$CONFIG_DIR"
else
    echo "[INFO] skipping; neovim is already available"
fi
