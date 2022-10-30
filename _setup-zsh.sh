#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
readonly REPO_DIR="${HOME}/.config/zsh"

mkdir -p "$REPO_DIR"

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v zsh)" ]]; then

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        sudo apt install -y zsh

        echo "---------------------------------"
        echo "     zsh-syntax-highlighting"
        echo "---------------------------------"
        mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
        if [[ -d zsh-syntax-highlighting ]]; then
            (
            cd zsh-syntax-highlighting || exit
            git pull
            )
        else
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${REPO_DIR}/zsh-syntax-highlighting"
        fi

        echo "---------------------------------"
        echo "     zsh-autosuggestions"
        echo "---------------------------------"
        mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
        if [[ -d zsh-autosuggestions ]]; then
            (
            cd zsh-autosuggestions || exit
            git pull
            )
        else
            git clone https://github.com/zsh-users/zsh-autosuggestions "${REPO_DIR}/zsh-autosuggestions"
        fi
    fi


    # homebrew's olivierverdier/zsh-git-prompt is unmaintained.
    echo "---------------------------------"
    echo "     zsh-git-prompt"
    echo "---------------------------------"
    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [[ -d zsh-git-prompt ]]; then
        (
        cd zsh-git-prompt || exit
        git pull
        )
    else
        git clone https://github.com/zsh-git-prompt/zsh-git-prompt "${REPO_DIR}/zsh-git-prompt"
    fi

    [[ -f ~/.zshrc ]] && mv -f ~/.zshrc ~/.zshrc.backup
    ln -sf "$BASEDIR"/.zshrc ~
    [[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.backup
    ln -sf "$BASEDIR"/.zshenv ~

    sudo chsh -s "$(command -v zsh)" "$(whoami)"
fi
