#!/usr/bin/env bash

# * Usage
# Run `./_setup-tmux.sh`
# Then it will download source and build tmux under <repo-root>.

readonly CMD=tmux
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$($CMD -V | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

VER="$(echo "$VERSION" | cut -c 1-4)"

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v tmux)" ]] || [[ "$confirm" == [yY] ]]; then
    BASEDIR="$(dirname "$(readlink -f "$0")")"
    readonly BASEDIR
    readonly CONFDIR="${HOME}/confs"

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ -x "$(command -v apt)" ]] && [[ "$(uname -s)" == "Linux" ]]; then
        cd "$CONFDIR"
        sudo apt install -y libevent-dev libncurses5-dev libncursesw5-dev
        curl -L "https://github.com/tmux/tmux/releases/download/${VER}/tmux-${VERSION}.tar.gz" | tar xzf -
        cd "tmux-${VERSION}"
        ./configure && make -j4
        [[ ! -d ~/bin ]] && mkdir ~/bin
        mv tmux ~/bin

        # clipboard integration
        sudo apt install -y xsel wl-clipboard
    fi

    [[ -f "${HOME}/.tmux.conf" ]] && mv -f "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.backup"
    ln -sf "${BASEDIR}/.tmux.conf" ~
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        cd ~/.tmux/plugins/tpm && git pull
    fi

fi
