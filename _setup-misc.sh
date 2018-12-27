#!/bin/bash

APPS="cmake htop autojump wget curl gnupg2 source-highlight jq python parallel neofetch p7zip"

if [ $(uname -s) == "Darwin" ]; then
    brew install $(printf "$APPS")
elif [ $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
    sudo apt install -y $(printf "$APPS")
fi
