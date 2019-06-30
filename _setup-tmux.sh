#!/bin/bash

# * Usage
# Run `./_setup-tmux.sh`
# Then it will download source and build tmux under <repo-root>.

VERSION="3.0-rc3"
VER=$(echo $VERSION | cut -c 1-3)

if [ "$1" = "-f" ] || [ ! -x "$(command -v tmux)" ]; then

    BASEDIR=$(dirname $(readlink -f "$0"))
    CONFDIR="${HOME}/confs"

    if [ $(uname -s) == "Darwin" ]; then
        brew install tmux
    elif [ -x $(command -v apt) ] && [ $(uname -s) == "Linux" ]; then
        cd "$CONFDIR"
        sudo apt install libevent-dev libncurses5-dev libncursesw5-dev
        curl -L "https://github.com/tmux/tmux/releases/download/${VER}/tmux-${VERSION}.tar.gz" | tar xzf -
        cd "tmux-${VERSION}"
        ./configure && make -j4
        [ ! -d ~/bin ] && mkdir ~/bin
        mv tmux ~/bin

        # clipboard integration
        sudo apt install xclip
    fi

    [ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
    cp "${BASEDIR}"/.tmux.conf ~
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        cd ~/.tmux/plugins/tpm && git pull
    fi

fi
