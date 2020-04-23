#!/usr/bin/env bash

APPS="cmake pkg-config htop autojump wget curl source-highlight jq parallel neofetch p7zip unzip tree trash-cli"

if [ "$(uname -s)" == "Darwin" ]; then
    for app in ${APPS}; do
        brew install "$(printf "%s" "$app")"
    done
elif [ "$(uname -s)" == "Linux" ] && [ -x "$(command -v apt)" ]; then
    for app in ${APPS}; do
        sudo apt install -y "$(printf "%s" "$app")"
    done
fi
