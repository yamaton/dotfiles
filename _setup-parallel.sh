#!/usr/bin/env bash

CMD=parallel

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | head -1 | cut -d ' ' -f3)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -p "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ] || [[ "$confirm" == [yY] ]]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    else
        URI="http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2"
        wget -N "$URI"
        FILE=$(basename "$URI")
        tar xvf ./"$FILE"
        cd parallel-*/
        ./configure
        make -j4
        sudo make install
        cd ..
        rm -f ./"$FILE"
        rm -rf parallel-*/
    fi
fi
