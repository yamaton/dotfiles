#!/usr/bin/env bash

readonly CMD=delta
readonly HOMEBREW_NAME=git-delta

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${HOMEBREW_NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            readonly URI="https://github.com/dandavison/delta/releases/download/${VERSION}/git-delta-musl_${VERSION}_amd64.deb"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            readonly URI="https://github.com/dandavison/delta/releases/download/${VERSION}/git-delta_${VERSION}_armhf.deb"
        fi
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        sudo apt install ./"$FILE"
        rm -f ./"$FILE"
    fi

    wget -N "https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.bash"
    mkdir -p ~/.bash_completion.d && mv -f completion.bash ~/.bash_completion.d/delta

    wget -N "https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh"
    mkdir -p ~/.zfunc && mv -f completion.zsh ~/.zfunc/_delta

    if [[ -f ~/.gitconfig ]]; then
        echo "―― $(date +"%H:%M:%S") - Delta setup ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
        echo "[INFO] Detected ~/.gitconfig --- add some lines from _delta.gitconfig if needed."
        echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
    else
        BASEDIR="$(dirname "$(readlink -f "$0")")"
        readonly BASEDIR
        cp "$BASEDIR"/_delta.gitconfig ~/.gitconfig
    fi
fi
