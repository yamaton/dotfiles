#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
readonly CMD="emacs"

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]]; then

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
        sudo apt install -y emacs-nox --no-install-recommends
    fi

    [[ -f ~/.emacs ]] && mv -f ~/.emacs ~/.emacs.backup
    ln -sf "${BASEDIR}/.emacs" ~
fi
