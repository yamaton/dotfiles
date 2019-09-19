#!/usr/bin/env bash
CMD=fzf

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "${CMD}"
        "$(brew --prefix)"/opt/fzf/install
    elif [ "$(uname -s)" == "Linux" ]; then
        if [ -d ~/.fzf ]; then
            cd ~/.fzf && git pull && ./install
        else
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        fi
    fi
fi
