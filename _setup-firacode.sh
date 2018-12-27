#!/bin/bash


if [ $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
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

    sudo apt update
    sudo apt install -y fonts-firacode

else
    VERSION="1.206"
    URI="https://github.com/tonsky/FiraCode/releases/download/${VERSION}/FiraCode_${VERSION}.zip"
    7z x "./FiraCode_${VERSION}.zip"
    echo "Take care of the rest and install Fira Code font manually "
fi