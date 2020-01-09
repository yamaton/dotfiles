#!/usr/bin/env bash

NAME=broot
CMD=br
VERSION="0.11.3"
if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$NAME"
    elif [ -x "$(command -v apt)" ]; then
        if [ "$(uname -m)" == "x86_64" ]; then
        URI="https://github.com/Canop/$NAME/releases/download/v$VERSION/$NAME"
        mkdir -p ~/bin && cd ~/bin
        wget -N "$URI"
        chmod +x ./"$NAME"
        ./"$NAME" --install
        fi
    fi
fi
