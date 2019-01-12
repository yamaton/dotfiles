#!/bin/bash

APPS="cmake htop autojump wget curl gnupg2 source-highlight jq python parallel neofetch p7zip tree"

if [ $(uname -s) == "Darwin" ]; then
    for app in "${APPS}"; do
        brew install $(printf "${app}")
    done
elif [ $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
    for app in "${APPS}"; do
        sudo apt install -y $(printf "${app}")
    done
fi
