#!/usr/bin/env bash

BASEDIR=$(dirname "$(readlink -f "$0")")
REPO_DIR="${HOME}/confs"


if [ "$1" = "-f" ] || [ ! -x "$(command -v zsh)" ]; then

    if [ "$(uname -s)" == "Darwin" ]; then
        brew install zsh zsh-completions
    elif [ "$(uname -s)" == "Linux" ] && [ -x "$(command -v apt)" ]; then
        sudo apt install -y zsh
    fi

    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [ -d zsh-syntax-highlighting ]; then
        (
        cd zsh-syntax-highlighting || exit
        git pull
        )
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    fi

    if [ -d zsh-git-prompt ]; then
        (
        cd zsh-git-prompt || exit
        git pull
        )
    else
        git clone https://github.com/starcraftman/zsh-git-prompt.git
    fi

    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
    cp "$BASEDIR"/.zshrc ~
    [ -f ~/.zshenv ] && mv ~/.zshenv ~/.zshenv.backup
    cp "$BASEDIR"/.zshenv ~

fi
