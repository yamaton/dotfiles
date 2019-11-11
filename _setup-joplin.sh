#!/usr/bin/env bash

CMD=joplin
VER="1.0.173"
BASEDIR=$(dirname "$(readlink -f "$0")")
BIN_DIR="${HOME}/bin"
CONFIG_DIR="${HOME}/.config/nvim"
FILE="$CMD.appimage"
URL="https://github.com/laurent22/joplin/releases/download/v$VER/Joplin-$VER-x86_64.AppImage"


## [TODO] add appimage version once it works
if [ "$1" = "-f" ] || [ ! -x "$(command -v $CMD)" ]; then

    if [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v apt)" ]; then
        mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
        wget -N "$URL"
	mv "$(basename $URL)" "$FILE"
	chmod +x "$FILE"
        sudo apt install -y fuse
        [ -L "$CMD" ] && rm -f "$CMD" 
        ln -s "$FILE" "$CMD"
    fi

else
    echo "[INFO] skipping; neovim is already available"
fi
