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

wget https://github.com/jarun/nnn/releases/download/v2.0/nnn_2.0-1_ubuntu18.04.amd64.deb
sudo apt install ./nnn_2.0-1_ubuntu18.04.amd64.deb


# if [ "$os_str" == "Ubuntu" ]; then
#     wget https://github.com/jarun/nnn/releases/download/v2.0/nnn_2.0-1_ubuntu18.04.amd64.deb
#     sudo apt install ./nnn_2.0-1_ubuntu18.04.amd64.deb
# else
#     if [ "$os_str" == "Debian" ]; then
#         wget https://github.com/jarun/nnn/releases/download/v2.0/nnn_2.0-1_debian9.amd64.deb
#         sudo apt install ./nnn_2.0-1_debian9.amd64.deb
#     else
#         cd "${REPO_DIR}"
#         echo "REPO_DIR: ${REPO_DIR}"
#         if [ ! -d nnn ]; then
#             git clone https://github.com/jarun/nnn.git
#             cd nnn
#         else
#             cd nnn
#             git pull
#         fi
#         make
#         sudo make install
#     fi
# fi