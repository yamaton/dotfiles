#!/usr/bin/env bash

CMD="xsv"
VERSION=$(curl https://formulae.brew.sh/api/formula-linux/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install ${CMD}
    elif [ "$(uname -s)" == "Linux" ] && [ "$(uname -m)" == "x86_64" ]; then
        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        ARCH=$(uname -m | tr '[:upper:]' '[:lower:]')
        URI="https://github.com/BurntSushi/xsv/releases/download/${VERSION}/${CMD}-${VERSION}-${ARCH}-unknown-${OS}-musl.tar.gz"
        curl -L "${URI}" | tar xzf -
        [ ! -d ~/bin ] &&  mkdir ~/bin
        mv ${CMD} ~/bin
    else
	echo "[WARNING] Not installing ${CMD}. Build it oneself."
    fi
fi
