#!/usr/bin/env bash

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash 
mkdir -p ~/bin
ln -sf ~/.joplin/Joplin.AppImage ~/bin/joplin

# CMD=joplin
# VER=$(curl --silent https://formulae.brew.sh/api/cask/${CMD}.json | jq '.version' | tr -d \")
# BASEDIR=$(dirname "$(readlink -f "$0")")
# BIN_DIR="${HOME}/bin"
# FILE="$CMD.appimage"
# URL="https://github.com/laurent22/joplin/releases/download/v$VER/Joplin-$VER.AppImage"
# 
# 
# ## [TODO] add appimage version once it works
# if [ "$1" = "-f" ] || [ ! -x "$(command -v $CMD)" ]; then
# 
#     if [ "$(uname -m)" == "x86_64" ] && [ "$(uname -s)" == "Linux" ]; then
#         mkdir -p "$BIN_DIR" && cd "$BIN_DIR"
#         wget -N "$URL"
#         mv "$(basename $URL)" "$FILE"
#         chmod +x "$FILE"
#         sudo apt install -y fuse
#         [ -L "$CMD" ] && rm -f "$CMD"
#         ln -s "$FILE" "$CMD"
#     fi
# 
# else
#     echo "[INFO] skipping; $CMD is already available"
# fi
