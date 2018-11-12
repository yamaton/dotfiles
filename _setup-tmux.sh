#!/bin/bash

# * Usage
# Run `./_setup-tmux.sh`
# Then it will download source and build tmux under <repo-root>.

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

cd "$CONFDIR"

sudo apt install libevent-dev libncurses5-dev libncursesw5-dev
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
tar xzf ./tmux-2.8.tar.gz
cd tmux-2.8
./configure && make -j4


[ ! -d ~/bin ] && mkdir ~/bin
mv tmux ~/bin


[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
cp "${BASEDIR}"/.tmux.conf ~
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm