#!/usr/bin/env bash

# * Usage
# Run `./_setup-tldr.sh <target-dir>`
# Then it will clone tlcr-cpp-client under <target-dir> and install it.

readonly CMD="tldr"

readonly REPO_DIR="${HOME}/confs"
[[ ! -d "$REPO_DIR" ]] && mkdir "${REPO_DIR}"

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "${CMD}"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
        sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
        cd "${REPO_DIR}" || exit
        [[ ! -d tldr-cpp-client ]] &&
            git clone https://github.com/tldr-pages/tldr-cpp-client.git
        cd tldr-cpp-client
        git pull
        ./deps.sh
        make
        sudo make install
    fi

    cp autocomplete/complete.zsh ~/.tldr.complete
fi
