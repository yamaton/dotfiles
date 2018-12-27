#!/bin/bash

# * Usage
# Run `./_setup-tmux.sh`
# Then it will download source and build tmux under <repo-root>.

VERSION="2.8"

if [ "$1" = "-f" ] || [ ! -x "$(command -v tmux)" ]; then

    BASEDIR=$(dirname $(readlink -f "$0"))
    CONFDIR="${HOME}/confs"

    if [ $(uname -s) == "Darwin" ]; then
        brew install tmux
    else
        cd "$CONFDIR"
        sudo apt install libevent-dev libncurses5-dev libncursesw5-dev
        curl -L "https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz" | tar xzf -
        cd "tmux-${VERSION}"
        ./configure && make -j4
        [ ! -d ~/bin ] && mkdir ~/bin
        mv tmux ~/bin
    fi

    [ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
    cp "${BASEDIR}"/.tmux.conf ~
    [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fi
