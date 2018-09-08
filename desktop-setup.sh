#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
echo "BASEDIR: ${BASEDIR}"


# neovim
## [TODO] add appimage version once it works
cd "${BASEDIR}"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim


# vscode
cd "${BASEDIR}"
sudo ./_setup-vscode.sh
cp ./vscode/settings.json ~/.config/Code/User/settings.json


# misc software
sudo apt install -y meld terminator


# fonts-firacode
cd "${BASEDIR}"
sudo ./_setup-firacode.sh
