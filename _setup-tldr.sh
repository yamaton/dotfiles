#!/bin/bash

# * Usage
# Run `./_setup-tldr.sh <target-dir>`
# Then it will clone tlcr-cpp-client under <target-dir> and install it.

CMD="tldr"

if [ "$#" -gt 0 ]; then
    REPO_DIR="$1"
else
    REPO_DIR="${HOME}/confs"
    [ ! -d "$REPO_DIR" ] && mkdir "${REPO_DIR}"
fi

if [ "$1" = "-f" ] || [ ! -x "$(command -v ${CMD})" ]; then
    if [ $(uname -s) == "Darwin"]; then
        brew install "${CMD}"
    elif [ $(uname -s) == "Linux"]; then
        sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
        cd "${REPO_DIR}"
        if [ ! -d tldr-cpp-client ]; then
            git clone https://github.com/tldr-pages/tldr-cpp-client.git
            cd tldr-cpp-client
        else
            cd tldr-cpp-client
            git pull
        fi
        ./deps.sh
        make
        sudo make install
    fi

    cp autocomplete/complete.zsh ~/.tldr.complete
fi
