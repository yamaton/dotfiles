#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))


if [ "$1" = "-f" ] || [ ! -x "$(command -v zsh)" ]; then

    if [ $(uname -s) == "Darwin" ]; then
        brew install zsh
    elif [ $(uname -s) == "Linux" ] && [ -x "$(command -v apt)" ]; then
        sudo apt install -y zsh
    fi

    REPO_DIR="${HOME}/confs"
    [ ! -d "$REPO_DIR" ] && mkdir "$REPO_DIR"

    cd ${REPO_DIR}
    if [ -d zsh-syntax-highlighting ]; then
        cd zsh-syntax-highlighting
        git pull
        cd ..
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    fi

    if [ -d zsh-git-prompt ]; then
        cd zsh-git-prompt
        git pull
        cd ..
    else
        git clone https://github.com/starcraftman/zsh-git-prompt.git
    fi

    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
    cp "${BASEDIR}"/.zshrc ~
    [ -f ~/.zshenv ] && mv ~/.zshenv ~/.zshenv.backup
    cp "${BASEDIR}"/.zshenv ~

fi