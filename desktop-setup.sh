#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
echo "BASEDIR: ${BASEDIR}"

# nvim
## add appimage version once it works
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
cp "${BASEDIR}"/init.vim ~/.config/nvim/init.vim

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'


sudo apt update
sudo apt -y install code
cp "${BASEDIR}"/vscode/settings.json ~/.config/Code/User/settings.json

# misc software
sudo apt install -y meld


# Edit /etc/apt/sources.list for FiraCode installation
os_str=$(lsb_release -i -s)
echo $os_str

if [ "$os_str" == "Debian" ]
then
    sudo cat << 'EOF' > /etc/apt/sources.list
deb http://deb.debian.org/debian stretch main contrib non-free
deb-src http://deb.debian.org/debian stretch main contrib non-free

deb http://deb.debian.org/debian stretch-updates main contrib non-free
deb-src http://deb.debian.org/debian stretch-updates main contrib non-free

deb http://security.debian.org/debian-security/ stretch/updates main contrib non-free
deb-src http://security.debian.org/debian-security/ stretch/updates main contrib non-free
EOF
elif [ "$os_str" == "Ubuntu" ]
    sudo add-apt-repository universe
fi

sudo apt install -y fonts-firacode
