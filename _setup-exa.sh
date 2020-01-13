#!/usr/bin/env bash

CMD=exa

if [ -x "$(command -v $CMD)" ]; then
    VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")
    CURRENT=$("$CMD" --version | cut -d ' ' -f2 | cut -d 'v' -f2)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "Current version is the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "Update available: ${VERSION} (current ${CURRENT})"
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v exa)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v cargo)" ] ; then
    cargo install "$CMD"
    else
    echo "cargo is missing. Exiting without installing exa..."
    fi
fi
