#!/usr/bin/env bash
CMD=fzf
VERSION=$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")

if [ -x "$(command -v $CMD)" ]; then
    CURRENT=$("$CMD" --version | cut -d ' ' -f1)
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
        brew install "${CMD}"
        "$(brew --prefix)"/opt/fzf/install
    elif [ "$(uname -s)" == "Linux" ]; then
        URI="https://github.com/junegunn/fzf/archive/${VERSION}.tar.gz"
        rm -rf ~/.fzf && mkdir ~/.fzf
        wget -N "$URI"
        FILE="$(basename $URI)"
        tar xvzf ./"$FILE" -C ~/.fzf
        rm -f "$FILE"
        ~/.fzf/"fzf-${VERSION}"/install
    fi
fi
