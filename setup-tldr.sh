#!/bin/bash

# * Usage
# Run `./setup-dldr.sh <target-dir>`
# Then it will clone tlcr-cpp-client under <target-dir> and install it.
#
if [ "$#" -gt 0 ]; then
    REPO_DIR="$1"
else
    REPO_DIR="$HOME"/repos
    if [ ! -d "$REPO_DIR" ]; then
        mkdir "$REPO_DIR"
    fi
fi
sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
cd "${REPO_DIR}"
git clone https://github.com/tldr-pages/tldr-cpp-client.git tldr-cpp-client
cd tldr-cpp-client
./deps.sh
make
sudo make install
mv "${REPO_DIR}"/tldr-cpp-client/autocomplete/complete.zsh ~/.tldr.complete
echo "source ~/.tldr.complete" >> ~/.zshrc