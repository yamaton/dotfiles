#!/bin/bash

# * Usage
# Run `./_setup-nnn.sh <repo-root>`
# Then it will clone nnn under <repo-root> and install it.

if [ "$#" -gt 0 ]; then
    REPO_DIR="$1"
else
    REPO_DIR="$HOME"/confs
    if [ ! -d "$REPO_DIR" ]; then
        mkdir "$REPO_DIR"
    fi
fi

codename=$(lsb_release -s -c)

if [ "$codename" == "bionic" ]; then
    echo "[INFO] getting deb for $codename"
    wget https://github.com/jarun/nnn/releases/download/v2.1/nnn_2.1-1_ubuntu18.04.amd64.deb
    sudo apt install ./nnn_2.1-1_ubuntu18.04.amd64.deb
else
    if [ "$codename" == "stretch" ]; then
        echo "[INFO] getting deb for $codename"
        wget https://github.com/jarun/nnn/releases/download/v2.1/nnn_2.1-1_debian9.amd64.deb
        sudo apt install ./nnn_2.1-1_debian9.amd64.deb
    else
        echo "[INFO] build nnn"
        cd "${REPO_DIR}"
        echo "REPO_DIR: ${REPO_DIR}"
        if [ ! -d nnn ]; then
            git clone https://github.com/jarun/nnn.git
            cd nnn
        else
            cd nnn
            git pull
        fi
        make
        sudo make install
    fi
fi