#!/usr/bin/env bash

readonly CMD=delta
readonly HOMEBREW_NAME=git-delta

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${HOMEBREW_NAME}.json | jq '.versions.stable' | tr -d '\" \n')"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | ./removecolor | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        case "$(uname -m)" in
            "x86_64") readonly FILE="git-delta-musl_${VERSION}_amd64.deb" ;;
            "armv7l") readonly FILE="git-delta_${VERSION}_armhf.deb" ;;
            "aarch64") readonly FILE="git-delta_${VERSION}_arm64.deb" ;;
            *) echo "Binary for arch not found. Exiting..." && exit 1
        esac
        readonly URI="https://github.com/dandavison/delta/releases/download/${VERSION}/${FILE}"
        wget -N "$URI"
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
        BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
        readonly BASEDIR
        cp "$BASEDIR"/_delta.gitconfig ~/.gitconfig
    fi
fi
