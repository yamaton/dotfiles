#!/bin/bash

VERSION="1.206"

codename=$(lsb_release -c -s)
if [ "$codename" == "stretch" ]; then
    echo "[INFO] Adding contrib non-free to /etc/apt/sources.list"
    # Edit /etc/apt/sources.list
    sudo cat << 'EOF' > /etc/apt/sources.list
deb http://deb.debian.org/debian stretch main contrib non-free
deb-src http://deb.debian.org/debian stretch main contrib non-free

deb http://deb.debian.org/debian stretch-updates main contrib non-free
deb-src http://deb.debian.org/debian stretch-updates main contrib non-free

deb http://security.debian.org/debian-security/ stretch/updates main contrib non-free
deb-src http://security.debian.org/debian-security/ stretch/updates main contrib non-free
EOF
fi


if [ $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
    sudo apt update
    sudo apt install -y fonts-firacode
else
    [ ! -d ~/.fonts ] && mkdir ~/.fonts
    cd ~/.fonts
    URI="https://github.com/tonsky/FiraCode/releases/download/${VERSION}/FiraCode_${VERSION}.zip"
    wget -N "${URI}"
    7z x "./FiraCode_${VERSION}.zip"
fi
