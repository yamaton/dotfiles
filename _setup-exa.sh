#!/usr/bin/env bash

CMD=exa

VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d ' ' -f2 | cut -d 'v' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -p "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v exa)" ] || [[ "$confirm" == [yY] ]]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v cargo)" ] ; then
    cargo install "$CMD"
    else
    echo "cargo is missing. Exiting without installing exa..."
    fi
fi
