#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
echo "BASEDIR: ${BASEDIR}"


# neovim
## [TODO] add appimage version once it works
echo "-------------------------"
echo "   neovim"
echo "-------------------------"
if [ ! -x "$(command -v nvim)" ]; then
    sudo apt install neovim
    cd "${BASEDIR}"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p ~/.config/nvim
    cp ./init.vim ~/.config/nvim/init.vim
else
    echo "[INFO] skipping; neovim is already available"
fi

# vscode
echo "-------------------------"
echo "   vscode"
echo "-------------------------"
if [ ! -x "$(command -v code)" ]; then
    cd "${BASEDIR}"
    ./_setup-vscode.sh
    cp ./vscode/settings.json ~/.config/Code/User/settings.json
else
    echo "[INFO] skipping; vscode is already available"
fi

# misc software
echo "-------------------------"
echo "   terminator"
echo "-------------------------"
sudo apt install -y terminator --no-install-recommends

echo "-------------------------"
echo "   meld"
echo "-------------------------"
sudo apt install -y meld --no-install-recommends


# fonts-firacode
echo "-------------------------"
echo "   Fira code fonts"
echo "-------------------------"
cd "${BASEDIR}"
./_setup-firacode.sh


echo "-------------------------"
echo "   Source Code Pro fonts"
echo "   (just downloading..)"
echo "-------------------------"
cd "${BASEDIR}"
./_download_fonts.sh