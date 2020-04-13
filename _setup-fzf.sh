#!/usr/bin/env bash
CMD=fzf
VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d ' ' -f1)
    if [ "$VERSION" == "$CURRENT" ]; then
        echo "Current version is the latest: ${CMD} ${CURRENT}"
        exit 1
    else
        echo "Update available: ${VERSION} (current ${CURRENT})"
    fi
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "${CMD}"
        "$(brew --prefix)"/opt/fzf/install
    elif [ "$(uname -s)" == "Linux" ]; then
        if [ -d ~/.fzf ]; then
            cd ~/.fzf && git pull && ./install
        else
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        fi
    fi
fi
