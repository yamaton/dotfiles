#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# * Usage
# Run `./_setup-tmux.sh`
# Then it will download source and build tmux under <repo-root>.

readonly CMD=tmux
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq -r '.versions.stable')"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$($CMD -V | cut -d ' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

VER="$(echo "$VERSION" | cut -c 1-4)"

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v tmux)" ]] || [[ "$confirm" == [yY] ]]; then
    BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    readonly BASEDIR
    readonly CONFDIR="${HOME}/confs"

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(command -v apt)" ]] && [[ "$(uname -s)" == "Linux" ]]; then
        cd "$CONFDIR" || (echo "$CONFDIR not found" && exit)
        sudo apt install -y libevent-dev libncurses5-dev libncursesw5-dev
        curl -L "https://github.com/tmux/tmux/releases/download/${VER}/tmux-${VERSION}.tar.gz" | tar xzf -
        (
            cd "tmux-${VERSION}" || (echo "tmux-${VERSION} not found" && exit)
            ./configure && make -j "$(nproc)"
            mkdir -p ~/.local/bin
            mv tmux ~/.local/bin

            mkdir -p ~/.local/share/man/man1
            mv tmux.1 ~/.local/share/man/man1
            mandb ~/.local/share/man
        )
        rm -rf "tmux-${VERSION}"

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
