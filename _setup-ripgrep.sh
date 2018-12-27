#!/bin/bash

VERSION="0.10.0"

if [ "$1" = "-f" ] || [ ! -x "$(command -v rg)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install ripgrep
    else
        if [ "$(uname -m)" == "x86_64" ]; then
            URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep_${VERSION}_amd64.deb"
            wget "${URI}"
            sudo apt install "./ripgrep_${VERSION}_amd64.deb"
        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
            curl -L "${URI}" | tar xzf -
            cp "ripgrep-${VERSION}-arm-unknown-linux-gnueabihf/rg" ~/bin
        fi
    fi
fi
