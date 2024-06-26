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
            chmod -R 755 "${REPO_DIR}/zsh-syntax-highlighting"
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
            chmod -R 755 "${REPO_DIR}/zsh-autosuggestions"
        fi
    fi


    echo "---------------------------------"
    echo "     git-prompt.zsh"
    echo "---------------------------------"
    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [[ -d git-prompt.zsh ]]; then
        (
        cd git-prompt.zsh || exit
        git pull
        )
    else
        git clone https://github.com/woefe/git-prompt.zsh "${REPO_DIR}/git-prompt.zsh"
        chmod -R 755 "${REPO_DIR}/git-prompt.zsh"
    fi


    echo "---------------------------------"
    echo "     zsh-abbr"
    echo "---------------------------------"
    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [[ -d zsh-abbr ]]; then
        (
        cd zsh-abbr || exit
        git pull
        )
    else
        git clone https://github.com/olets/zsh-abbr "${REPO_DIR}/zsh-abbr"
        chmod -R 755 "${REPO_DIR}/zsh-abbr"
    fi


    echo "---------------------------------"
    echo "     zsh-completions-bio"
    echo "---------------------------------"
    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [[ -d zsh-completions-bio ]]; then
        (
        cd zsh-completions-bio || exit
        git pull
        )
    else
        git clone https://github.com/yamaton/zsh-completions-bio "${REPO_DIR}/zsh-completions-bio"
        chmod -R 755 "${REPO_DIR}/zsh-completions-bio"
    fi

    echo "---------------------------------"
    echo "     zsh-completions-extra"
    echo "---------------------------------"
    mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
    if [[ -d zsh-completions-extra ]]; then
        (
        cd zsh-completions-extra || exit
        git pull
        )
    else
        git clone https://github.com/yamaton/zsh-completions-extra "${REPO_DIR}/zsh-completions-extra"
        chmod -R 755 "${REPO_DIR}/zsh-completions-extra"
    fi

    [[ -f ~/.zshrc ]] && mv -f ~/.zshrc ~/.zshrc.backup
    ln -sf "$BASEDIR"/.zshrc ~
    [[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.backup
    ln -sf "$BASEDIR"/.zshenv ~

    sudo chsh -s "$(command -v zsh)" "$(whoami)"
fi
