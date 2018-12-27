#!/bin/bash

APPS="cmake htop autojump wget curl gnupg2 source-highlight jq csvtool python parallel"

if [ $(uname -s) == "Darwin" ]; then
    brew install $(printf "$APPS")
elif [ $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
    sudo apt install -y $(printf "$APPS")
fi
