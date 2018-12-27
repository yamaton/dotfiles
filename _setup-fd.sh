#!/bin/bash

CMD="fd"
VERSION="v7.2.0"

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then

    if [ $(uname -s) == "Darwin" ]; then
        brew install "${CMD}"
    elif [ $(uname -s) == "Linux" ]; then
        if [ "$(uname -m)" == "x86_64" ]; then
            URI="https://github.com/sharkdp/fd/releases/download/${VERSION}/fd-musl_${VERSION}_amd64.deb"
            curl -L "${URI}" | sudo apt install -
        elif [ "$(uname -m)" == "armv7l" ]; then
            URI="https://github.com/sharkdp/fd/releases/download/${VERSION}/fd-${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
            curl -L "${URI}" | tar xzf -
            [ ! -d ~/bin ] &&  mkdir ~/bin
            cp "fd-${VERSION}-arm-unknown-linux-gnueabihf/${CMD}" ~/bin
        fi
    fi

fi
