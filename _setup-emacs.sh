#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
readonly CMD="emacs"

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]]; then

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        sudo apt install -y emacs-nox
    fi

    [[ -e ~/.emacs ]] && mv ~/.emacs ~/.emacs.backup
    ln -s "${BASEDIR}/.emacs" ~
fi
