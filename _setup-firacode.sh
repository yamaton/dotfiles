#!/bin/bash

# Edit /etc/apt/sources.list
codename=$(lsb_release -c -s)

if [ "$codename" == "stretch" ]; then
    echo "[INFO] Adding contrib non-free"
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
