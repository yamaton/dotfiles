#!/bin/bash

VERSION="0.11.0"

if [ "$1" = "-f" ] || [ ! -x "$(command -v bat)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install bat
    else
        if [ "$(uname -m)" == "x86_64" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_amd64.deb"
            wget -N "${URI}"
            sudo apt install "./bat_${VERSION}_amd64.deb"
            rm -f "./bat_${VERSION}_amd64.deb"

        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_armhf.deb"
            wget -N "${URI}"
            sudo apt install "./bat_${VERSION}_armhf.deb"
            rm -f "./bat_${VERSION}_armhf.deb"
        fi
    fi
fi
