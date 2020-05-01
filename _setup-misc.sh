#!/usr/bin/env bash

APPS=$(cat ./apps.txt)

if [ "$(uname -s)" == "Darwin" ]; then
    for app in ${APPS}; do
        brew install "$(printf "%s" "$app")"
    done
elif [ "$(uname -s)" == "Linux" ] && [ -x "$(command -v apt)" ]; then
    for app in ${APPS}; do
        sudo apt install -y "$(printf "%s" "$app")"
    done
fi
