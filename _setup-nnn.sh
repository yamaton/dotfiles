#!/bin/bash

# * Usage
# Run `./_setup-nnn.sh <repo-root>`
# Then it will clone nnn under <repo-root> and install it.

if [ "$#" -gt 0 ]; then
    REPO_DIR="$1"
else
    REPO_DIR="$HOME"/repos
    if [ ! -d "$REPO_DIR" ]; then
        mkdir "$REPO_DIR"
    fi
fi

echo "REPO_DIR: ${REPO_DIR}"

sudo apt install -y libncursesw5-dev
cd "${REPO_DIR}"
if [ ! -d nnn ]; then
    git clone https://github.com/jarun/nnn.git
    cd nnn
else
    cd nnn
    git pull
fi
make
sudo make install

