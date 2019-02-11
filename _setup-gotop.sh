#!/bin/bash

CMD="gotop"
VERSION="2.0.1"

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -m)" == "x86_64" ]; then
        ARCH="amd64"
    elif [ "$(uname -m)" == "armv7l" ]; then
        ARCH="arm7"
    fi

    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    URI="https://github.com/cjbassi/${CMD}/releases/download/${VERSION}/${CMD}_${VERSION}_${OS}_${ARCH}.tgz"
    curl -L "${URI}" | tar xzf -
    [ ! -d ~/bin ] && mkdir ~/bin
    mv "${CMD}" ~/bin
fi
